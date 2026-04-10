Return-Path: <linux-erofs+bounces-3275-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEdqLhbh2GnHjAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3275-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 13:37:58 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D893D6434
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 13:37:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsZYH0JdXz2yZ6;
	Fri, 10 Apr 2026 21:37:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.181.183.35
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775821074;
	cv=none; b=g94NXduCV3SLKabDghPGYURCG3Yq6FlQeVjdZX2XMldVXtz6qEDr5EuA0QHDAd3+lBbvKkgtcK+Rp114smjyitkgPf37nKJ43IWBnoRomMREOBEkRTKNUBxRQdSuk2djC/LzYzpoGWBgdz9WnREFLvmweH3rHjiISMGjNbaibFMEYJRIv0zY6CqVs60VSb+uNY2+SbbSfv9SVM68bzvyFLW1kSgewmg8C+NpXvqdZ9mWijqpjpt/25wLtiGYwWG3hLuXJZTnT8m1BoELS7VEqHkeXGa56Ks42NNfeZ7YcQ7TcSIxHs2nr/trfViEr3ise4GeWTkI01tnAsPD0akpDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775821074; c=relaxed/relaxed;
	bh=6WsEJXucoKRozB9yhaMSM4vTEo1NShe9owzam8g5Iqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ghP8jsqKIGaSse1sWXX24m+FLm3swGNV+wnPHcrvOUbz6Kf4fKHW3fuM1s6aee/T1eE9p8f8KIguTF8VjHrzGvLhv03flopXdxNiz/nKvO1vh04k0YRUNnZJk0mt0K/cX/veyaQLziTMdda1C3hQwLD5KXrD7Obu9QCIzvP0eBdlzhRXeDZZEEn9SOhyZLJqg8HJo/7B/S43Miqh/BQGPrya05mysyFzs+wJaZb4XOBR1L+50+OEGpgb7Z0gVXzZUtixSLed3gvapYUHDBbRzfSba4BZpImTULi6gzTL1/xkembzpW3OpLllFfJ59APkPcAMfn5px478ZUEfzm73sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=ou0HGaWo; dkim-atps=neutral; spf=pass (client-ip=95.181.183.35; helo=mx5.sberdevices.ru; envelope-from=avkrasnov@salutedevices.com; receiver=lists.ozlabs.org) smtp.mailfrom=salutedevices.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=ou0HGaWo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=salutedevices.com (client-ip=95.181.183.35; helo=mx5.sberdevices.ru; envelope-from=avkrasnov@salutedevices.com; receiver=lists.ozlabs.org)
Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsZYC2WJsz2xT6
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 21:37:49 +1000 (AEST)
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id E009C240004;
	Fri, 10 Apr 2026 14:37:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru E009C240004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1775821065;
	bh=6WsEJXucoKRozB9yhaMSM4vTEo1NShe9owzam8g5Iqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=ou0HGaWoVJnwaZjnA1OgCGY6mk88lFS/gIboi9iSgStAMA3Gci7/ILqs32iXCXg3/
	 N/3B7DKFEe328ciQg6JUPPJ5HGls0oCthpxghdF849HtKsCr5ORUfQ3N588xmTkBH2
	 gcb6geNXm4ZYuMymycG8srzzDW3HRN767Wrh44ScK5t3VQhUkcBucl0sTNmnVzKVWI
	 Hx0gTmowqRYDaipvCJXt+mZkq13AFKCzWrobopmg9fHb8ymFjL8wK5j1InbTQQR+/2
	 NfsVr+CSPRBmZmOR1JXHmNcw3cZEFq8U3tmZG/37p78P5I2ZB5OF/tyXwmWlygosVY
	 CAsWENqx8aDxw==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 10 Apr 2026 14:37:45 +0300 (MSK)
Message-ID: <2e916997-0557-45e7-831a-b436c07c5ba4@salutedevices.com>
Date: Fri, 10 Apr 2026 14:37:43 +0300
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: erofs pointer corruption and kernel crash
Content-Language: ru
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <oxffffaa@gmail.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>, Gao Xiang
	<xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>, Sheng Yong <shengyong1@xiaomi.com>
References: <4a2f3801-fac1-42fe-ae75-da315822e088@salutedevices.com>
 <f1ed0cff-57ff-4fb3-b102-0a0a6d79f1a9@linux.alibaba.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <f1ed0cff-57ff-4fb3-b102-0a0a6d79f1a9@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.28.3.98]
X-ClientProxiedBy: p-exch-cas-a-m1.sberdevices.ru (172.24.201.216) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 98 0.3.98 ca9d2f3beca9ca2a85e178af9d8e97d5fa2c38a3, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 202177 [Apr 10 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/04/09 21:06:00 #28382314
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[salutedevices.com,none];
	R_DKIM_ALLOW(-0.20)[salutedevices.com:s=post];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3275-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORGED_SENDER(0.00)[avkrasnov@salutedevices.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:oxffffaa@gmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:kernel@salutedevices.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:shengyong1@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[gmail.com,lists.ozlabs.org,vger.kernel.org,salutedevices.com,kernel.org,linux.alibaba.com,google.com,huawei.com,xiaomi.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	HAS_XOIP(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@salutedevices.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[salutedevices.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,salutedevices.com:dkim,salutedevices.com:mid]
X-Rspamd-Queue-Id: C2D893D6434
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



10.04.2026 11:31, Gao Xiang wrote:
> Hi,
> 
> On 2026/4/10 16:13, Arseniy Krasnov wrote:
>> Hi,
>>
>> We found unexpected behaviour of erofs:
>>
>> There is function in erofs - 'erofs_onlinefolio_end()'. It has pointer to
>> 'struct folio' as first argument, and there is loop inside this function,
>> which updates 'private' field of provided folio:
>>
>>    do {
>>            orig = atomic_read((atomic_t *)&folio->private);
>>            DBG_BUGON(orig <= 0);
>>            v = dirty << EROFS_ONLINEFOLIO_DIRTY;
>>            v |= (orig - 1) | (!!err << EROFS_ONLINEFOLIO_EIO);
>>    } while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
>>
>> Now, we see that in some rare case, this function processes folio, where
>> 'private' is pointer, and thus this loop will update some bits in this
>> pointer. Then later kernel dereferences such pointer and crashes.
>>
>> To catch this, the following small debug patch was used (e.g. we check that 'private' field is pointer):
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 33cb0a7330d2..b1d8deffec4d 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -238,6 +238,11 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
>>   {
>>       int orig, v;
>>   +    if (((uintptr_t)folio->private) & 0xffff000000000000) {
> 
> No, if erofs_onlinefolio_end() is called, `folio->private`
> shouldn't be a pointer, it's just a counter inside, and
> storing a pointer is unexpected.
> 
> And since the folio is locked, it shouldn't call into
> try_to_free_buffers().
> 
> Is it easy to reproduce? if yes, can you print other
> values like `folio->mapping` and `folio->index` as
> well?
> 
> I need more informations to find some clues.



So reproduced again with this debug patch which adds magic to 'struct z_erofs_pcluster' and prints 'struct folio'
when pointer in 'private' is passed to 'erofs_onlinefolio_end()'. In short - 'private' points to 'struct z_erofs_pcluster'.

Patch itself:


diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 33cb0a7330d2..6eb975facce1 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -234,10 +234,132 @@ void erofs_onlinefolio_split(struct folio *folio)
 	atomic_inc((atomic_t *)&folio->private);
 }
 
+static void dump_folio_address_space(const struct address_space *mapping)
+{
+	pr_emerg("[foliodbg] %s struct address_space (%p):\ni_ino=0x%lx\ns_dev=0x%x\n"
+		"i_rdev=0x%x\ngfp_mask=%lx\ni_mmap_writable=%d\nnrpages=%lu\n"
+		"writeback_index=%lu flags=0x%lx\nwb_err=%x\ni_private_data=%px\n"
+		"\n",
+		__func__, mapping,
+		(mapping && mapping->host) ? mapping->host->i_ino : 0,
+		(mapping && mapping->host && mapping->host->i_sb) ? mapping->host->i_sb->s_dev : 0,
+		(mapping && mapping->host) ? mapping->host->i_rdev : 0,
+		mapping ? (unsigned long)mapping->gfp_mask : 0,
+		mapping ? atomic_read(&mapping->i_mmap_writable) : 0,
+		mapping ? mapping->nrpages : 0,
+		mapping ? mapping->writeback_index : 0,
+		mapping ? mapping->flags : 0,
+		mapping ? mapping->wb_err : 0,
+		mapping ? mapping->i_private_data : NULL
+	);
+}
+
+static void dump_folio_page(const struct page *page)
+{
+	pr_emerg("[foliodbg] %s struct page (%p):\nflags=0x%lx\nindex=%lu\n"
+		"privat=0x%lx\npage_type(mapcount)=0x%x\n"
+#ifdef CONFIG_MEMCG
+		"memcg_data=0x%lx\n"
+#elif defined(CONFIG_SLAB_OBJ_EXT)
+		"unused_slab_obj_exts=0x%lx\n"
+#endif
+#if defined(WANT_PAGE_VIRTUAL)
+		"virtual=%p\n"
+#endif
+#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+		"_last_cpupid=%d\n"
+#endif
+		"refcount=%d\n"
+		"\n",
+		__func__, page, page->flags, page->index, page->private,
+		page->page_type,
+#ifdef CONFIG_MEMCG
+		page->memcg_data,
+#elif defined(CONFIG_SLAB_OBJ_EXT)
+		page->_unused_slab_obj_exts,
+#endif
+#if defined(WANT_PAGE_VIRTUAL)
+		page->virtual,
+#endif
+#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+		page->_last_cpupid,
+#endif
+		atomic_read(&page->_refcount)
+	);
+}
+
+static void dump_folio(const struct folio *folio)
+{
+	pr_emerg("[foliodbg] %s struct folio (%p):\nflags=0x%lx\nindex=%lu\n"
+		"private=%px\nmapcount=%d\nrefcount=%d\n"
+#ifdef CONFIG_MEMCG
+		"memcg_data=0x%lx\n"
+#elif defined(CONFIG_SLAB_OBJ_EXT)
+		"unused_slab_obj_exts=0x%lx\n"
+#endif
+#if defined(WANT_PAGE_VIRTUAL)
+		"virtual=%p\n"
+#endif
+#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+		"_last_cpupid=%d\m"
+#endif
+		"flags_1=0x%lx\nhead_1=0x%lx\nlarge_mapcount=%d\nnr_pages_mapped=%d\n"
+#ifdef CONFIG_64BIT
+		"entire_mapcount=%d\npincount=%d\n"
+#endif /* CONFIG_64BIT */
+		"mm_id_mapcount=[%d, %d]\nmapcount_1=%d\nrefcount_1=%d\n"
+#ifdef NR_PAGES_IN_LARGE_FOLIO
+		"nr_pages=%d\n"
+#endif /* NR_PAGES_IN_LARGE_FOLIO */
+		"flags_2=0x%lx\nhead_2=0x%lx\n"
+		"flags_3=0x%lx\nhead_3=0x%lx\n"
+		"\n",
+		__func__, folio,
+		folio->flags, folio->index, folio->private,
+		atomic_read(&folio->_mapcount), atomic_read(&folio->_refcount),
+#ifdef CONFIG_MEMCG
+		folio->memcg_data,
+#elif defined(CONFIG_SLAB_OBJ_EXT)
+		folio->_unused_slab_obj_exts,
+#endif
+#if defined(WANT_PAGE_VIRTUAL)
+		folio->virtual,
+#endif
+#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+		folio->_last_cpupid,
+#endif
+		folio->_flags_1, folio->_head_1,
+		atomic_read(&folio->_large_mapcount),
+		atomic_read(&folio->_nr_pages_mapped),
+#ifdef CONFIG_64BIT
+		atomic_read(&folio->_entire_mapcount),
+		atomic_read(&folio->_pincount),
+#endif /* CONFIG_64BIT */
+		folio->_mm_id_mapcount[0], folio->_mm_id_mapcount[1],
+		atomic_read(&folio->_mapcount_1),
+		atomic_read(&folio->_refcount_1),
+#ifdef NR_PAGES_IN_LARGE_FOLIO
+		folio->_nr_pages,
+#endif /* NR_PAGES_IN_LARGE_FOLIO */
+		folio->_flags_2, folio->_head_2,
+		folio->_flags_3, folio->_head_3
+	);
+
+	dump_folio_page(&folio->page);
+	dump_folio_address_space(folio->mapping);
+	print_hex_dump(KERN_EMERG, "folio private", DUMP_PREFIX_ADDRESS, 16, 1,
+		       folio->private, 32, true);
+}
 void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
 {
 	int orig, v;
 
+	if (((uintptr_t)folio->private) & 0xffff000000000000) {
+		pr_emerg("\n[foliodbg] %s:%d EROFS FOLIO %px PRIVATE BEFORE %px\n", __func__, __LINE__, folio, folio->private);
+		dump_folio(folio);
+		dump_stack();
+	}
+
 	do {
 		orig = atomic_read((atomic_t *)&folio->private);
 		DBG_BUGON(orig <= 0);
@@ -245,6 +367,9 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
 		v |= (orig - 1) | (!!err << EROFS_ONLINEFOLIO_EIO);
 	} while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
 
+	if (((uintptr_t)folio->private) & 0xffff000000000000)
+		pr_emerg("\n[foliodbg] %s:%d EROFS FOLIO %px PRIVATE SET %px\n", __func__, __LINE__, folio, folio->private);
+
 	if (v & (BIT(EROFS_ONLINEFOLIO_DIRTY) - 1))
 		return;
 	folio->private = 0;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d21ae4802c7f..e8f295e90b05 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -38,6 +38,7 @@ __Z_EROFS_BVSET(z_erofs_bvset_inline, Z_EROFS_INLINE_BVECS);
  * A: Field should be accessed / updated in atomic for parallelized code.
  */
 struct z_erofs_pcluster {
+	u64 magic;
 	struct mutex lock;
 	struct lockref lockref;
 
@@ -262,6 +263,8 @@ static struct z_erofs_pcluster *z_erofs_alloc_pcluster(unsigned int size)
 		pcl = kmem_cache_zalloc(pcs->slab, GFP_KERNEL);
 		if (!pcl)
 			return ERR_PTR(-ENOMEM);
+
+		pcl->magic = 0x435053464F52455AULL;
 		return pcl;
 	}
 	return ERR_PTR(-EINVAL);



Crash result (tail of log was corrupted a little due to second sequential catch of this problem):



[  684.634126][  T919] [foliodbg] erofs_onlinefolio_end:358 EROFS FOLIO fffffdffc00420c0 PRIVATE BEFORE ffff000004442780
[  684.642007][  T919] [foliodbg] dump_folio struct folio (00000000cf314425):
[  684.642007][  T919] flags=0x1ff0000000004320
[  684.642007][  T919] index=3392
[  684.642007][  T919] private=ffff000004442780
[  684.642007][  T919] mapcount=-1
[  684.642007][  T919] refcount=3
[  684.642007][  T919] memcg_data=0x0
[  684.642007][  T919] flags_1=0x1ff0000000000000
[  684.642007][  T919] head_1=0x0
[  684.642007][  T919] large_mapcount=290
[  684.642007][  T919] nr_pages_mapped=-559087616
[  684.642007][  T919] entire_mapcount=0
[  684.642007][  T919] pincount=0
[  684.642007][  T919] mm_id_mapcount=[1102, 0]
[  684.642007][  T919] mapcount_1=-1
[  684.642007][  T919] refcount_1=1
[  684.642007][  T919] nr_pages=14937858
[  684.642007][  T919] flags_2=0x1ff0000000000000
[  684.642007][  T919] head_2=0x0
[  684.642007][  T919] flags_3=0x1ff0000000000000
[  684.642007][  T919] head_3=0x0
[  684.642007][  T919]
[  684.744491][  T919] [foliodbg] dump_folio_page struct page (00000000cf314425):
[  684.744491][  T919] flags=0x1ff0000000004320
[  684.744491][  T919] index=3392
[  684.744491][  T919] privat=0xffff000004442780
[  684.744491][  T919] page_type(mapcount)=0xffffffff
[  684.744491][  T919] memcg_data=0x0
[  684.744491][  T919] refcount=3
[  684.744491][  T919]
[  684.779714][  T919] [foliodbg] dump_folio_address_space struct address_space (0000000000000000):
[  684.779714][  T919] i_ino=0x0
[  684.779714][  T919] s_dev=0x0
[  684.779714][  T919] i_rdev=0x0
[  684.779714][  T919] gfp_mask=0
[  684.779714][  T919] i_mmap_writable=0
[  684.779714][  T919] nrpages=0
[  684.779714][  T919] writeback_index=0 flags=0x0
[  684.779714][  T919] wb_err=0
[  684.779714][  T919] i_private_data=0000000000000000
[  684.779714][  T919]
[  684.826573][  T919] folio private000000009ef9d99a: 5a 45 52 4f 46 53 50 43 00 00 00 00 00 00 00 00  ZEROFSPC........
[  684.831621][  T919] folio private000000007d6aa995: 00 00 00 00 00 00 00 00 98 27 44 04 00 00 ff ff  .........'D.....
[  684.842031][  T919] CPU: 0 UID: 0 PID: 919 Comm: kworker/0:14H Tainted: G           O        6.15.11-sdkernel #6 PREEMPT
[  684.842056][  T919] Tainted: [O]=OOT_MODULE
[  684.842076][  T919] Workqueue: kverityd verity_work
[  684.842098][  T919] Call trace:
[  684.842103][  T919]  show_stack+0x18/0x30 (C)
[  684.842123][  T919]  dump_stack_lvl+0x60/0x80
[  684.842138][  T919]  dump_stack+0x18/0x24
[  684.842156][  T919]  erofs_onlinefolio_end+0x264/0x2b0
[  684.842185][  T919]  z_erofs_decompress_queue+0x4c0/0x8e0
[  684.842211][  T919]  z_erofs_decompress_kickoff+0x88/0x150
[  684.842226][  T919]  z_erofs_endio+0x144/0x250
[  684.842246][  T919]  bio_endio+0x138/0x150
[  684.842266][  T919]  __dm_io_complete+0x1e0/0x2b0
[  684.842282][  T919]  clone_endio+0xd0/0x270
[  684.842302][  T919]  bio_endio+0x138/0x150
[  684.842322][  T919]  verity_finish_io+0x64/0xf0
[  684.842345][  T919]  verity_work+0x30/0x40
[  684.842355][  T919]  process_one_work+0x180/0x2e0
[  684.842375][  T919]  worker_thread+0x2c4/0x3f0
[  684.842394][  T919]  kthread+0x12c/0x210
[  684.842414][  T919]  ret_from_fork+0x10/0x20
[  684.842434][  T919]
[  684.842434][  T919] [foliodbg] erofs_onlinefolio_end:371 EROFS FOLIO fffffdffc00420c0 PRIVATE SET ffff00002444277f
[  684.958838][ T2486] ALSA: PCM: [Q] Lost interrupts?: (stream=1, delta=6576, new_hw_ptr=4943792, old_hw_ptr=4937216)
[  684.969204][ T2485] ALSA: PCM: [Q] Lost interrupts?: (stream=1, delta=2352, new_hw_ptr=1646016, old_hw_ptr=1643664)
[  685.015481][   T40] Unable to handle kernel paging request at virtual address ffff00002444277f
[  685.021334][   T40] Mem abort info:
[  685.021989][   T40]   ESR = 0x0000000096000006
[  685.026898][   T40]   EC = 0x25: DABT (current EL), IL = 32 bits
[  685.035918][   T40]   SET = 0, FnV = 0
[  685.035986][   T40]   EA = 0, S1PTW = 0
[  685.039855][   T40]   FSC = 0x06: level 2 translation fault
[  685.045343][   T40] Data abort info:
[  685.049827][   T40]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[  685.060195][   T40]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  685.060700][   T40]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  685.066643][   T40] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000001e36000
[  685.074075][   T40] [ffff00002444277f] pgd=1800000007fff403, p4d=1800000007fff403, pud=1800000007ffe403, pmd=0000000000000000
[  685.086103][   T40] Internal error: Oops: 0000000096000006 [#1]  SMP
[  685.091448][   T40] Modules linked in: vlsicomm(O)
[  685.092319][  T928]
[  685.092319][  T928] [foliodbg] erofs_onlinefolio_end:358 EROFS FOLIO fffffdffc00420c0 PRIVATE BEFORE ffff00002444277f
[  685.096180][   T40] CPU: 0 UID: 0 PID: 40 Comm: kswapd0 Tainted: G           O        6.15.11-sdkernel #6 PREEMPT
[  685.096194][   T40] Tainted: [O]=OOT_MODULE
[  685.096199][   T40] Hardware name: SberDevices SberBoom Mini (DT)
[  685.096205][   T40] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  685.096214][   T40] pc : drop_buffers.constprop.0+0x34/0x120
[  685.096233][   T40] lr : try_to_free_buffers+0xd0/0x100
[  685.096244][   T40] sp : ffff800081063780
[  685.096248][   T40] x29: ffff800081063780 x28: 0000000000000000 x27: fffffdffc00420c8
[  685.096265][   T40] x26: ffff8000810638a0 x25: ffff800081063868 x24: 0000000000000001
[  685.122584][  T928] [foliodbg] dump_folio struct folio (00000000cf314425):
[  685.122584][  T928] flags=0x1ff0000000004201
[  685.122584][  T928] index=3392
[  685.122584][  T928] private=ffff00002444277f
[  685.122584][  T928] mapcount=-1
[  685.122584][  T928] refcount=4
[  685.122584][  T928] memcg_data=0x0
[  685.122584][  T928] flags_1=0x1ff0000000000000
[  685.122584][  T928] head_1=0x0
[  685.122584][  T928] large_mapcount=290
[  685.122584][  T928] nr_pages_mapped=-559087616
[  685.122584][  T928] entire_mapcount=0
[  685.122584][  T928] pincount=0
[  685.122584][  T928] mm_id_mapcount=[1102, 0]
[  685.122584][  T928] mapcount_1=-1
[  685.122584][  T928] refcount_1=1
[  685.122584][  T928] nr_pages=14937858
[  685.122584][  T928] flags_2=0x1ff0000000000000
[  685.122584][  T928] head_2=0x0
[  685.122584][  T928] flags_3=0x1ff0000000000000
[  685.122584][  T928] head_3=0x0
[  685.122584][  T928]
[  685.123256][   T40]
[  685.123259][   T40] x23: fffffdffc00420c0 x22: ffff8000810637b0 x21: fffffdffc00420c0
[  685.123275][   T40] x20: ffff00002444277f x19: ffff00002444277f x18: 0000000000000000
[  685.123290][   T40] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  685.129416][  T928] [foliodbg] dump_folio_page struct page (00000000cf314425):
[  685.129416][  T928] flags=0x1ff0000000004201
[  685.129416][  T928] index=3392
[  685.129416][  T928] privat=0xffff00002444277f
[  685.129416][  T928] page_type(mapcount)=0xffffffff
[  685.129416][  T928] memcg_data=0x0
[  685.129416][  T928] refcount=4
[  685.129416][  T928]
[  685.136882][   T40] x14: ffff7fff87288000 x13: 00589f68e49c5358 x12: ffff800080d59b58
[  685.136897][   T40] x11: 0000000000000002
[  685.142500][  T928] [foliodbg] dump_folio_address_space struct address_space (0000000000000000):
[  685.142500][  T928] i_ino=0x0
[  685.142500][  T928] s_dev=0x0
[  685.142500][  T928] i_rdev=0x0
[  685.142500][  T928] gfp_mask=0
[  685.142500][  T928] i_mmap_writable=0
[  685.142500][  T928] nrpages=0
[  685.142500][  T928] writeback_index=0 flags=0x0
[  685.142500][  T928] wb_err=0
[  685.142500][  T928] i_private_data=0000000000000000
[  685.142500][  T928]
[  685.147659][   T40]  x10: ffff800081063770 x9 : 0000000000000001
[  685.151841][  T928] Unable to handle kernel paging request at virtual address ffff00002444277f
[  685.159394][   T40]
[  685.159399][   T40] x8 : ffff8000810637d0 x7 : 0000000000000000 x6 : 0000000000000000
[  685.167188][  T928] Mem abort info:
[  685.248399][   T40]
[  685.248406][   T40] x5 : 0000000000000000 x4 : fffffdffc00420c0 x3 : 1ff0000000004201
[  685.248421][   T40] x2 : 1ff0000000004201
[  685.252253][  T928]   ESR = 0x0000000096000006
[  685.258322][   T40]  x1 : ffff8000810637b0 x0 : fffffdffc00420c0
[  685.258335][   T40] Call trace:
[  685.258340][   T40]  drop_buffers.constprop.0+0x34/0x120 (P)
[  685.258359][   T40]  try_to_free_buffers+0xd0/0x100
[  685.266380][  T928]   EC = 0x25: DABT (current EL), IL = 32 bits
[  685.273848][   T40]  filemap_release_folio+0x94/0xc0
[  685.273865][   T40]  shrink_folio_list+0x8c8/0xc40
[  685.306455][  T928]   SET = 0, FnV = 0
[  685.313609][   T40]  shrink_lruvec+0x740/0xb80
[  685.313624][   T40]  shrink_node+0x2b8/0x9a0
[  685.318050][  T928]   EA = 0, S1PTW = 0
[  685.359062][   T40]  balance_pgdat+0x3b8/0x760
[  685.359077][   T40]  kswapd+0x220/0x3b0
[  685.359096][   T40]  kthread+0x12c/0x210
[  685.359108][   T40]  ret_from_fork+0x10/0x20
[  685.359127][   T40] Code: 14000004 f9400673 eb13029f 54000180 (f9400262)
[  685.359134][   T40] ---[ end trace 0000000000000000 ]---
[  685.372682][   T40] Kernel panic - not syncing: Oops: Fatal exception
[  685.372694][   T40] SMP: stopping secondary CPUs
[  685.373561][   T40] Kernel Offset: disabled
[  685.373565][   T40] CPU features: 0x0000,00000000,01000000,0200420b
[  685.373576][   T40] Memory Limit: none


Thanks


> 
> Thanks,
> Gao Xiang
> 
>> +        pr_emerg("\n[foliodbg] %s:%d EROFS FOLIO %px PRIVATE BEFORE %px\n", __func__, __LINE__, folio, folio->private);
>> +        dump_stack();
>> +    }
>> +
>>       do {
>>           orig = atomic_read((atomic_t *)&folio->private);
>>           DBG_BUGON(orig <= 0);
>> @@ -245,6 +250,9 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
>>           v |= (orig - 1) | (!!err << EROFS_ONLINEFOLIO_EIO);
>>       } while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
>>   +    if (((uintptr_t)folio->private) & 0xffff000000000000)
>> +        pr_emerg("\n[foliodbg] %s:%d EROFS FOLIO %px PRIVATE SET %px\n", __func__, __LINE__, folio, folio->private);
>> +
>>       if (v & (BIT(EROFS_ONLINEFOLIO_DIRTY) - 1))
>>           return;
>>       folio->private = 0;
>>
>>
>> And it gives result:
>>
>> [][  T639] [foliodbg] erofs_onlinefolio_end:242 EROFS FOLIO fffffdffc0030440 PRIVATE BEFORE ffff000002b32468
>> [][  T639] CPU: 0 UID: 0 PID: 639 Comm: kworker/0:6H Tainted: G O 6.15.11-sdkernel #1 PREEMPT
>> [][  T639] Tainted: [O]=OOT_MODULE
>> [][  T639] Workqueue: kverityd verity_work
>> [][  T639] Call trace:
>> [][  T639]  show_stack+0x18/0x30 (C)
>> [][  T639]  dump_stack_lvl+0x60/0x80
>> [][  T639]  dump_stack+0x18/0x24
>> [][  T639]  erofs_onlinefolio_end+0x124/0x130
>> [][  T639]  z_erofs_decompress_queue+0x4b0/0x8c0
>> [][  T639]  z_erofs_decompress_kickoff+0x88/0x150
>> [][  T639]  z_erofs_endio+0x144/0x250
>> [][  T639]  bio_endio+0x138/0x150
>> [][  T639]  __dm_io_complete+0x1e0/0x2b0
>> [][  T639]  clone_endio+0xd0/0x270
>> [][  T639]  bio_endio+0x138/0x150
>> [][  T639]  verity_finish_io+0x64/0xf0
>> [][  T639]  verity_work+0x30/0x40
>> [][  T639]  process_one_work+0x180/0x2e0
>> [][  T639]  worker_thread+0x2c4/0x3f0
>> [][  T639]  kthread+0x12c/0x210
>> [][  T639]  ret_from_fork+0x10/0x20
>> [][  T639]
>> [][  T639] [foliodbg] erofs_onlinefolio_end:254 EROFS FOLIO fffffdffc0030440 PRIVATE SET ffff000022b32467
>> [][   T39] Unable to handle kernel paging request at virtual address ffff000022b32467
>> [][   T39] Mem abort info:
>> [][   T39]   ESR = 0x0000000096000006
>> [][   T39]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [][   T39]   SET = 0, FnV = 0
>> [][   T39]   EA = 0, S1PTW = 0
>> [][   T39]   FSC = 0x06: level 2 translation fault
>> [][   T39] Data abort info:
>> [][   T39]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
>> [][   T39]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>> [][   T39]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [][   T39] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000001e36000
>> [][   T39] [ffff000022b32467] pgd=1800000007fff403, p4d=1800000007fff403, pud=1800000007ffe403, pmd=0000000000000000
>> [][   T39] Internal error: Oops: 0000000096000006 [#1]  SMP
>> [][   T39] Modules linked in: vlsicomm(O)
>> [][   T39] CPU: 1 UID: 0 PID: 39 Comm: kswapd0 Tainted: G O 6.15.11-sdkernel #1 PREEMPT
>> [][   T39] Tainted: [O]=OOT_MODULE
>> [][   T39] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [][   T39] pc : drop_buffers.constprop.0+0x34/0x120
>> [][   T39] lr : try_to_free_buffers+0xd0/0x100
>> [][   T39] sp : ffff80008105b780
>> [][   T39] x29: ffff80008105b780 x28: 0000000000000000 x27: fffffdffc0030448
>> [][   T39] x26: ffff80008105b8a0 x25: ffff80008105b868 x24: 0000000000000001
>> [][   T39] x23: fffffdffc0030440 x22: ffff80008105b7b0 x21: fffffdffc0030440
>> [][   T39] x20: ffff000022b32467 x19: ffff000022b32467 x18: 0000000000000000
>> [][   T39] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000d69f4cc0
>> [][   T39] x14: ffff0000000c5dc0 x13: 0000000000000000 x12: ffff800080d59b58
>> [][   T39] x11: 00000000000000c0 x10: 0000000000000000 x9 : 0000000000000000
>> [][   T39] x8 : ffff80008105b7d0 x7 : 0000000000000000 x6 : 000000000000003f
>> [][   T39] x5 : 0000000000000000 x4 : fffffdffc0030440 x3 : 1ff0000000004001
>> [][   T39] x2 : 1ff0000000004001 x1 : ffff80008105b7b0 x0 : fffffdffc0030440
>> [][   T39] Call trace:
>> [][   T39]  drop_buffers.constprop.0+0x34/0x120 (P)
>> [][   T39]  try_to_free_buffers+0xd0/0x100
>> [][   T39]  filemap_release_folio+0x94/0xc0
>> [][   T39]  shrink_folio_list+0x8c8/0xc40
>> [][   T39]  shrink_lruvec+0x740/0xb80
>> [][   T39]  shrink_node+0x2b8/0x9a0
>> [][   T39]  balance_pgdat+0x3b8/0x760
>> [][   T39]  kswapd+0x220/0x3b0
>> [][   T39]  kthread+0x12c/0x210
>> [][   T39]  ret_from_fork+0x10/0x20
>> [][   T39] Code: 14000004 f9400673 eb13029f 54000180 (f9400262)
>> [][   T39] ---[ end trace 0000000000000000 ]---
>> [][   T39] Kernel panic - not syncing: Oops: Fatal exception
>> [][   T39] SMP: stopping secondary CPUs
>> [][   T39] Kernel Offset: disabled
>> [][   T39] CPU features: 0x0000,00000000,01000000,0200420b
>> [][   T39] Memory Limit: none
>> [][   T39] Rebooting in 5 seconds..
>>
>> So 'erofs_onlinefolio_end()' takes some folio with 'private' field contains
>> some pointer (0xffff000002b32468), "corrupts" this pointer (result will be
>> 0xffff000022b32467 - at least we see that 0x20000000 was ORed to original
>> pointer and this is (1 << EROFS_ONLINEFOLIO_DIRTY)), and then kernel crashes.
>> We guess it is not valid case when such folio is passed as argument to
>> 'erofs_onlinefolio_end()'.
>>
>> We have the following erofs configuration in buildroot:
>>
>> BR2_TARGET_ROOTFS_EROFS=y
>> BR2_TARGET_ROOTFS_EROFS_CUSTOM_COMPRESSION=y
>> BR2_TARGET_ROOTFS_EROFS_COMPRESSION_ALGORITHMS="zstd,22 --max-extent-bytes 65536 -E48bit"
>> BR2_TARGET_ROOTFS_EROFS_FRAGMENTS=y
>> BR2_TARGET_ROOTFS_EROFS_PCLUSTERSIZE=65536
>>
>>
>>
>> May be You know how to fix it or some ideas? Because we are new at erofs and need to discover and
>> learn its source code.
>>
>> Thanks
> 


