/// 近期最少使用缓存

/// 实现原理如下：
/// 1、采用循环双向列表，记录节点访问顺序；
/// 2、采用Map（实际为LinkHashMap）保存缓存的key和value；
/// 3、被插入或被访问的节点，向链表表尾移动，作为最新被访问的节点。
class LruCache<K, V> implements Map<K, V> {

    /// 链表表头，最晚访问节点
    _Entry<K, V>? head;
    /// 链表表尾，最近访问节点
    _Entry<K, V>? tail;

    /// 缓存最大容量
    final int maxSize;
    /// 缓存容器
    final Map<K, _Entry<K, V>> _cache = new Map();

    LruCache(this.maxSize): assert(maxSize > 0);

    /// map转为LruCache
    factory LruCache.of(Map<K, V> map, int maxSize) {
        LruCache<K, V> result = new LruCache<K, V>(maxSize);
        result.addAll(map);
        return result;
    }

    /// 获取缓存当前真实大小
    int get length => _cache.length;

    /// 获取缓存所有的value
    Iterable<V> get values {
        List<V> list = [];
        for (_Entry<K, V>? e = head; e != null; e = e.after) {
            list.add(e.value);
        }
        return list;
    }

    /// 获取缓存所有的key
    Iterable<K> get keys {
        List<K> list = [];
        for (_Entry<K, V>? e = head; e != null; e = e.after) {
            list.add(e.key);
        }
        return list;
    }

    /// 清空缓存
    void clear() {
        _cache.clear();
        head = tail = null;
    }
    

    /// 根据key获取value
    @override
    V? operator [](Object? key) {
        _Entry<K, V>? node = _cache[key];
        if (node == null) return null;
        _afterNodeAccess(node);
        return node.value;
    }

    /// 节点删除操作
    void _afterNodeRemoval(_Entry<K, V> e) {
        /// 暂存被删节点的，节点、前继、后继
        _Entry<K, V>? p = e, before = p.before, after = p.after;
        /// 将被删除节点的前继、后继置为null
        p.before = p.after = null;
        if (before == null) { /// 被删节点，为表头
            head = after; /// 将被删节点的后继，置为表头
        } else {
            before.after = after; /// 将被删节点的后继，指向它前继的后继指针
        }
        if (after == null) { /// 被删节点，为表尾
            tail = before; /// 将被删节点的前继，指向表尾
        } else {
            after.before = before; /// 将被删节点的前继，指向它后继的前继指针
        }
    }

    /// 移除key对应的value
    @override
    V? remove(Object? key) {
        _Entry<K, V>? node = _cache.remove(key);
        if (node == null) return null;
        _afterNodeRemoval(node);
        return node.value;
    }

    /// 往表尾插入节点（最近访问节点）
    void _linkNodeLast(_Entry<K, V> p) {
        _Entry<K, V>? last = tail;
        tail = p;
        if (last == null) {
            head = p;
        } else {
            p.before = last;
            last.after = p;
        }
    }

    /// 移除表头节点（最晚访问节点）
    V? removeHead() {
        _Entry<K, V>? head = this.head;
        if (head == null) {
            return null;
        }
        if (head == tail) {
            /// 只有1个节点，清空链表
            head.before = head.after = null;
            this.head = this.tail = null;
        } else {
            /// 多个节点，表头指针向表尾方向移动
            this.head = head.after;
            this.head?.before = null;
            head.after = null;
        }
        _cache.remove(head.key);
        return head.value;
    }

    /// 将被访问的节点，移动到表尾（即将被访问的节点置为最近访问节点）
    void _afterNodeAccess(_Entry<K, V> e) {
        _Entry<K, V>? last;
        if ((last = tail) != e) {
            /// 被访问节点，为链表中间节点，需将该节点移动至表尾作为最近被访问节点；
            /// 同时，将该节点的前后节点链接起来
            _Entry<K, V>? p = e, b = p.before, a = p.after;
            p.after = null;
            if (b == null) {
                head = a;
            } else {
                b.after = a;
            }
            if (a == null) {
                last = b;
            } else {
                a.before = b;
            }
            if (last == null) {
                head = p;
            } else {
                p.before = last;
                last.after = p;
            }
            tail = p;
        }
    }

    @override
    void addAll(Map<K, V> other) {
        assert(other != null);
        other.forEach((K key, V value) {
            this[key] = value;
        });
    }

    @override
    void addEntries(Iterable<MapEntry<K, V>> newEntries) {
        newEntries.forEach((MapEntry<K, V> entry) {
            this[entry.key] = entry.value;
        });
    }

    @override
    bool containsKey(Object? key) {
        return _cache.containsKey(key);
    }

    @override
    bool containsValue(Object? value) {
        for (_Entry<K, V>? e = head; e != null; e = e.after) {
            if (e.value == value) {
                return true;
            }
        }
        return false;
    }

    @override
    bool get isEmpty => _cache.isEmpty;

    @override
    bool get isNotEmpty => _cache.isNotEmpty;

    @override
    void forEach(void Function(K key, V value) f) {
        for (_Entry<K, V>? e = head; e != null; e = e.after) {
            f(e.key, e.value);
        }
    }

    @override
    void removeWhere(bool Function(K key, V value) predicate) {
        _cache.removeWhere((K _key, _Entry<K, V> _value) {
            if (predicate(_key, _value.value)) {
                _afterNodeRemoval(_value);
                return true;
            }
            return false;
        });
    }

    @override
    Iterable<MapEntry<K, V>> get entries {
        List<MapEntry<K, V>> list = [];
        for (_Entry<K, V>? e = head; e != null; e = e.after) {
            list.add(new MapEntry(e.key, e.value));
        }
        return list;
    }

    /// 创建新节点，并将其插入到表尾，作为最近访问节点
    _Entry<K, V> _createNew(K key, V value) {
        /// 创建新节点
        _Entry<K, V> entry = new _Entry(key: key, value: value);
        /// 插入到表尾，作为最近访问节点
        _linkNodeLast(entry);
        return entry;
    }

    /// 插入值
    void operator []=(K key, dynamic value) {
        _Entry<K, V>? node = _cache[key];
        if (node == null) {
            if (_cache.length == maxSize) {
                /// 达到最大容量，移除表头最晚节点
                removeHead();
            }
            _cache[key] = _createNew(key, value);
        } else {
            _afterNodeAccess(node);
        }
    }

    @override
    V putIfAbsent(K key, V Function() ifAbsent) {
        assert(ifAbsent != null);
        return _cache.putIfAbsent(key, () {
            V value = ifAbsent();
            return _createNew(key, value);
        }).value;
    }

    @override
    V update(K key, V Function(V value) update, {V Function()? ifAbsent}) {
        assert(update != null);
        var updateFunc = (_Entry<K, V> _value) {
            V value = update(_value.value);
            _value.value = value;
            _afterNodeAccess(_value);
            return _value;
        };
        if (ifAbsent != null) {
            return _cache.update(key, updateFunc, ifAbsent: () {
                V value = ifAbsent();
                return _createNew(key, value);
            }).value;
        } else {
            return _cache.update(key, updateFunc).value;
        }
    }

    @override
    void updateAll(V Function(K key, V value) update) {
        assert(update != null);
        _cache.updateAll((K _key, _Entry<K, V> _value) {
            V value = update(_key, _value.value);
            _value.value = value;
            return _value;
        });
    }

    Map<RK, RV> retype<RK, RV>() {
        throw new Exception("Not implement");
    }

    @override
    Map<RK, RV> cast<RK, RV>() {
        return _cache.cast<RK, RV>();
    }

    @override
    Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K key, V value) f) {
        throw new Exception("Not implement");
    }
}

class _Entry<K, V> {
    final K key;
    V value;
    /// 节点前继
    _Entry<K, V>? before;
    /// 节点后续
    _Entry<K, V>? after;

    _Entry({required this.key, required this.value});
}

