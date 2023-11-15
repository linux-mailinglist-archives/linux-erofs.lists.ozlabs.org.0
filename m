Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EEA7EBCC6
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Nov 2023 06:31:43 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SkP/dJVl;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SVWxS6qHPz3cNT
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Nov 2023 16:31:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SkP/dJVl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SVWxN3vsvz2xrD
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Nov 2023 16:31:35 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6c4eb5fda3cso4925716b3a.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 14 Nov 2023 21:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700026292; x=1700631092; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xP/JxA/rQnm+o+LKQglf2sQ5X566v83GMwtkkHWvSLU=;
        b=SkP/dJVlUouMbmD7lBlBtdvZAjm129xDNd0S/DKOwrs3AIH7slSmyTovrNRL9MZZHk
         g7fFtdWO/VE+fniehtELKSZZtjr/5XODcq9IkdDalOCZPdNeBQeg7LPpzjhcgx16Euq5
         mnHF9l9r3qUSmI+iZQj8GIHNizkvrFgf6G/GLsSR2Zr/0rKo23oqe2LYXG+mZlWLOG0P
         /N5ixhXmout/aCd41j0qvwAu1qkp/SqVFNjLYh0lx4RXwf++vsuRtPdlpQ9U/Wa8qDvD
         jqCwMxVet+/IuEXq20EPdtDFUzHXVhxHCxpeqZDHvAMRtlkqce+2O14T/jA83q1NQkXt
         kkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700026292; x=1700631092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xP/JxA/rQnm+o+LKQglf2sQ5X566v83GMwtkkHWvSLU=;
        b=JS/a1b2FMqbKmb9DvECZv2diOv2Cx7wlH3EVrU1yXwaYE+d0PLE3YNadBG1vuO7fi5
         XKJuMNh+rJyLy348mvsb+h3P36PRCCXbDOtuela6TBr3c8uuWmUBx4S7hQjDvAZv48U7
         AQBHWn+wLy2CIhBGNRu1Nshm8Zbion60VttJCFRJmUGbnJH7kQUuRQYkZKWnt3VQLOED
         DiILDGqocfn6j7pNXL/iqZoQ2wv/wIszpWKVMYJZKF7EK8ZcrG4VCr5vZkiVEPbtbd0n
         +4xsXCbZzG+5i3cLQawe9Ffm7nzugi6FVquUiUgn8vCJ9vbV9RgAOT1GvTcY0R0YS63j
         E8QA==
X-Gm-Message-State: AOJu0Yxa+W1JsA0SXWAOih/tSHuI1xKZpk040Jf/LMyzJWDvKoq7V9xO
	VLUfyBgxq7oR+wr2HYncgc+iHucL/4I=
X-Google-Smtp-Source: AGHT+IEoedeJ1OtBSdFaw8qxJkIuSzGhgSqbpTH+QGNNDzzTuMKRsHN933GB0fF0cyU5yXpLK5KxwQ==
X-Received: by 2002:a05:6a00:c8d:b0:6c6:1f0a:89c6 with SMTP id a13-20020a056a000c8d00b006c61f0a89c6mr14699862pfv.34.1700026291822;
        Tue, 14 Nov 2023 21:31:31 -0800 (PST)
Received: from localhost ([156.236.96.172])
        by smtp.gmail.com with ESMTPSA id fn2-20020a056a002fc200b00689f5940061sm2138278pfb.17.2023.11.14.21.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 21:31:31 -0800 (PST)
Date: Wed, 15 Nov 2023 13:31:25 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Li Yiyan <lyy0627@sjtu.edu.cn>
Subject: Re: [PATCH v1] erofs-utils: enhance fragment cache for fuse
Message-ID: <20231115133125.00004b08.zbestahu@gmail.com>
In-Reply-To: <20231023071528.1912105-1-lyy0627@sjtu.edu.cn>
References: <20231023071528.1912105-1-lyy0627@sjtu.edu.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yiyan,

The LRU cache implementation roughly looks good to me, I think you can just
send a refined patch so that we can thoroughly review it.

Now, I have several comments listed below, please check.

On Mon, 23 Oct 2023 15:15:28 +0800
Li Yiyan <lyy0627@sjtu.edu.cn> wrote:

> This is the initial draft of the fragment cache that
> I proposed for Fuse. I have added an LRU cache that allows us
> to check if there is a cached fragment block based on the offset
> when we need to read a fragment inode. If a cached block exists,
> we can then read it from memory, saving one disk read and one
> decompression step. This has resulted in a performance improvement
> of over ten times on Linux images with enabled fragments.
> Please note that my code has not been polished and thoroughly
> tested yet. It is only a preliminary implementation and
> performance validation of the idea.
> 
> I appreciate your valuable feedback in advance.
> 
> Draft for the fragment cache. Now just improve performance
> of first evaluation run, thanks to prefetching disk and avoiding
> decompression. When running next 9 runs, versions w/ and w/o fragment
> cache remain the same performance because no request read fragment
> actually due to page cache.
> 
> Dataset: linux 5.15
> Compression algorithm: -lzma
> Additional options: -C131072 -T0 -Efragments
> Test options: --warmup 3 -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1"

The hyperfine benchmarking tool should not require the use of `--warmup` if
the `-p` option is used in conjunction with the command `echo 3 > /proc/sys/vm/drop_caches`.

see https://github.com/sharkdp/hyperfine/blob/master/README.md#warmup-runs-and-preparation-commands

> 
> Evaluation result (w/o fragcache->lw/ fragcache avg time):
> 	- Sequence data: 252.617 s -> 19.171 s
> 	- Random data: 214.561 s -> 12.356 s
> 
> Signed-off-by: Li Yiyan <lyy0627@sjtu.edu.cn>
> ---
>  include/erofs/lru.h |  39 ++++++++++++++
>  lib/Makefile.am     |   3 +-
>  lib/data.c          |  76 ++++++++++++++++++++++++++++
>  lib/lru.c           | 121 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 238 insertions(+), 1 deletion(-)
>  create mode 100644 include/erofs/lru.h
>  create mode 100644 lib/lru.c
> 
> diff --git a/include/erofs/lru.h b/include/erofs/lru.h
> new file mode 100644
> index 0000000..cc8bf20
> --- /dev/null
> +++ b/include/erofs/lru.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/*
> + * JUST FOR EXPERIMENTAL USE
> + */
> +#ifndef __EROFS_CACHE_H
> +#define __EROFS_CACHE_H
> +
> +#include "erofs/list.h"
> +#include "erofs/hashmap.h"
> +
> +#define FRAGMENT_CACHE_SIZE (4096 * 1024)
> +
> +struct fragment_entry {
> +	struct hashmap_entry hentry;
> +
> +	u64 key;
> +	char *value;
> +	struct list_head node;
> +};
> +
> +struct lru_cache {
> +	struct list_head lru;
> +	struct hashmap map;
> +	int capacity;
> +	int size;
> +
> +	/* statistics */
> +	unsigned int hit;
> +	unsigned int miss;
> +	unsigned int evicted;
> +};
> +
> +struct lru_cache *lru_cache_new(int capacity);
> +void lru_cache_free(struct lru_cache *lru);
> +void lru_cache_remove(struct lru_cache *lru, const u64 key);
> +void *lru_cache_get(struct lru_cache *lru, const u64 key);
> +void lru_cache_put(struct lru_cache *lru, const u64 key, void *value);
> +
> +#endif
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index 54b9c9c..308cf49 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -19,6 +19,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
>        $(top_srcdir)/include/erofs/internal.h \
>        $(top_srcdir)/include/erofs/io.h \
>        $(top_srcdir)/include/erofs/list.h \
> +      $(top_srcdir)/include/erofs/lru.h \
>        $(top_srcdir)/include/erofs/print.h \
>        $(top_srcdir)/include/erofs/tar.h \
>        $(top_srcdir)/include/erofs/trace.h \
> @@ -34,7 +35,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
>  		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
>  		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
>  		      fragments.c dedupe.c uuid_unparse.c uuid.c tar.c \
> -		      block_list.c xxhash.c rebuild.c diskbuf.c
> +		      block_list.c xxhash.c rebuild.c diskbuf.c  lru.c
>  
>  liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
>  if ENABLE_LZ4
> diff --git a/lib/data.c b/lib/data.c
> index a87053f..bb46bab 100644
> --- a/lib/data.c
> +++ b/lib/data.c
> @@ -232,6 +232,45 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
>  	return 0;
>  }
>  
> +#define FRAGEMENT_CACHE 1
> +
> +#if FRAGEMENT_CACHE
> +#include "erofs/lru.h"
> +
> +struct lru_cache *fragment_cache;
> +
> +static void merge_cache(u64 off, u64 len, char *cache_data1, char *cache_data2,
> +			bool read_next, char *buffer)
> +{
> +	u64 cache_sz =
> +		(off / FRAGMENT_CACHE_SIZE + 1) * FRAGMENT_CACHE_SIZE - off;
> +
> +	if (read_next) {
> +		memcpy(buffer, cache_data1, cache_sz);
> +		memcpy(buffer + cache_sz, cache_data2,
> +		       len - cache_sz);
> +	} else {
> +		memcpy(buffer, cache_data1, len);
> +	}
> +}
> +
> +static int fetch_cache_fragment(struct erofs_inode *inode, u64 idx, char **data)
> +{
> +	int ret;
> +
> +	if (!data || !inode)
> +		return -1;
> +
> +	*data = malloc(FRAGMENT_CACHE_SIZE);
> +	ret = erofs_pread(inode, *data, FRAGMENT_CACHE_SIZE,
> +			  idx * FRAGMENT_CACHE_SIZE);
> +	if (!ret)
> +		lru_cache_put(fragment_cache, idx, *data);
> +
> +	return ret;
> +}
> +#endif
> +
>  int z_erofs_read_one_data(struct erofs_inode *inode,
>  			struct erofs_map_blocks *map, char *raw, char *buffer,
>  			erofs_off_t skip, erofs_off_t length, bool trimmed)
> @@ -241,6 +280,29 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
>  	int ret = 0;
>  
>  	if (map->m_flags & EROFS_MAP_FRAGMENT) {
> +#if FRAGEMENT_CACHE
> +		char *cache_data1, *cache_data2;
> +		u64 offset = inode->fragmentoff + skip;
> +		u64 idx = offset / FRAGMENT_CACHE_SIZE;
> +		bool read_next = (((idx + 1) * FRAGMENT_CACHE_SIZE - offset) <=
> +				  (length - skip));

Why not calculate the unit number based on the read length? This way, we can read
multiple units instead of just the next one.

> +
> +		erofs_dbg(
> +			"fragment offset %llu, idx %llu, len %llu, read_next %d",
> +			offset, idx, length - skip, read_next);
> +
> +		if (!fragment_cache)
> +			fragment_cache = lru_cache_new(1024);
> +
> +		cache_data1 = lru_cache_get(fragment_cache, idx);
> +		if (cache_data1 && read_next)
> +			cache_data2 = lru_cache_get(fragment_cache, idx + 1);
> +		if (cache_data1 && (!read_next || cache_data2)) {
> +			merge_cache(offset, length - skip, cache_data1,
> +				    cache_data2, read_next, buffer);
> +			return 0;
> +		}
> +#endif
>  		struct erofs_inode packed_inode = {
>  			.sbi = sbi,
>  			.nid = sbi->packed_nid,
> @@ -252,8 +314,22 @@ int z_erofs_read_one_data(struct erofs_inode *inode,
>  			return ret;
>  		}
>  
> +#if FRAGEMENT_CACHE
> +		ret = fetch_cache_fragment(&packed_inode, idx, &cache_data1);
> +		if (ret)
> +			return ret;
> +		if (read_next) {
> +			ret = fetch_cache_fragment(&packed_inode, idx + 1, &cache_data2);
> +			if (ret)
> +				return ret;
> +		}
> +		merge_cache(offset, length - skip, cache_data1,
> +			    cache_data2, read_next, buffer);
> +		return ret;
> +#else
>  		return erofs_pread(&packed_inode, buffer, length - skip,
>  				   inode->fragmentoff + skip);
> +#endif
>  	}
>  
>  	/* no device id here, thus it will always succeed */
> diff --git a/lib/lru.c b/lib/lru.c
> new file mode 100644
> index 0000000..3fb60b3
> --- /dev/null
> +++ b/lib/lru.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +/*
> + * JUST FOR EXPERIMENTAL USE
> + */
> +
> +#include "erofs/lru.h"
> +#include "erofs/defs.h"
> +
> +static int u64_cmp(const void *a, const void *b, const void *key)
> +{
> +	struct fragment_entry *ea = (struct fragment_entry *)a;
> +	struct fragment_entry *eb = (struct fragment_entry *)b;
> +
> +	return ea->key == eb->key;
> +}
> +
> +struct lru_cache *lru_cache_new(int capacity)
> +{
> +	struct lru_cache *cache = malloc(sizeof(struct lru_cache *));
> +
> +	if (!cache)
> +		return NULL;
> +	hashmap_init(&cache->map, u64_cmp, 0);
> +	init_list_head(&cache->lru);
> +	cache->capacity = capacity;
> +	cache->size = 0;
> +	cache->hit = cache->miss = cache->evicted = 0;
> +
> +	return cache;
> +}
> +
> +void lru_cache_free(struct lru_cache *lru)
> +{
> +	hashmap_free(&lru->map);
> +	free(lru);
> +}
> +
> +void *lru_cache_get(struct lru_cache *lru, const u64 key)
> +{
> +	unsigned int hash;
> +	struct fragment_entry *entry;
> +
> +	hash = memhash(&key, sizeof(key));
> +	entry = hashmap_get_from_hash(&lru->map, hash, &key);
> +
> +	if (entry) {
> +		list_del(&entry->node);
> +		list_add_tail(&entry->node, &lru->lru);
> +
> +		++lru->hit;
> +		erofs_dbg("statistic: hit %u, miss %u, evicted %u", lru->hit,
> +			  lru->miss, lru->evicted);
> +		return entry->value;
> +	}
> +
> +	++lru->miss;
> +	erofs_dbg("statistic: hit %u, miss %u, evicted %u", lru->hit, lru->miss,
> +		  lru->evicted);
> +	return NULL;
> +}
> +
> +void lru_cache_put(struct lru_cache *lru, const u64 key, void *value)
> +{
> +	unsigned int hash;
> +	struct fragment_entry *entry;
> +
> +	hash = memhash(&key, sizeof(key));
> +	entry = hashmap_get_from_hash(&lru->map, hash, &key);
> +	if (entry)
> +		return;
> +
> +	if (lru->size == lru->capacity) {
> +		struct fragment_entry *victim;
> +
> +		victim = list_first_entry(&lru->lru, struct fragment_entry,
> +					  node);
> +		list_del(&victim->node);
> +
> +		hashmap_remove(&lru->map, victim);
> +
> +		free(victim->value);
> +		free(victim);
> +		lru->size--;
> +
> +		++lru->evicted;
> +		erofs_dbg("statistic: hit %u, miss %u, evicted %u", lru->hit,
> +			  lru->miss, lru->evicted);
> +	}
> +
> +	entry = malloc(sizeof(struct fragment_entry));
> +	if (!entry)
> +		return;
> +
> +	entry->key = key;
> +	entry->value = value;
> +	if (!entry->value)
> +		return;
> +
> +	hashmap_entry_init(entry, hash);
> +	hashmap_add(&lru->map, entry);
> +	lru->size++;
> +
> +	list_add_tail(&entry->node, &lru->lru);
> +}
> +
> +void lru_cache_remove(struct lru_cache *lru, const u64 key)
> +{
> +	unsigned int hash;
> +	struct fragment_entry *entry;
> +
> +	hash = memhash(&key, sizeof(key));
> +	entry = hashmap_get_from_hash(&lru->map, hash, &key);
> +	if (entry) {
> +		list_del(&entry->node);
> +		hashmap_remove(&lru->map, entry);
> +
> +		free(entry->value);
> +		free(entry);
> +		lru->size--;
> +	}
> +}

