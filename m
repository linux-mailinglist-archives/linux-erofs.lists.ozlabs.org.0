Return-Path: <linux-erofs+bounces-2509-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBEaBwRgqWnj6QAAu9opvQ
	(envelope-from <linux-erofs+bounces-2509-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 11:50:44 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 709EA20FFD5
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 11:50:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRRCN0Rnjz3c5y;
	Thu, 05 Mar 2026 21:50:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772707840;
	cv=none; b=U8wl0UYicekd3/kdeJN94NXPUu9nDpqaS9fk11fKOgt2YH+Bjc2DldeLXZU9rZHDVsPQ1iRsjKWrMlPcGe5wZ50rwLHiMCRlUD9/RDoOGaU/D/OCWW2KwgFWabft7Cev25NOUelicDGY4UQF7f2J2bQ+YyoudA5C4HspeubQZR5AidR0623VYCnbDCBkZJ1Wsaq/sPojbyIPDfVsG8Yx1qHNAzPqWsFWKZIsyU/2AJiiNeTK9Jfj1jwc50QXNvXtk+3oSQjJdLufZMGrrEz2jSvznQlpTFA68muG7YqIzFoaD/sdUJdcgDt6UuHXGjhIF1If1QQ/bhfxVtbArT0B3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772707840; c=relaxed/relaxed;
	bh=KdXn73WYY0c8wrn6A7C95m0k5dXLcIGDqR+Uv+k43Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VY6TAbonSl+OYZUnh3yhpuplMC+eky+7jpFdxLxgWQmEjoCRj8zJ/M/6GkdKCG85NLDNujUIyEaCJYDdINtMlpLHlHSOpGiZKiP7hG7KBbzxhItDSGWV/EuPhhE8nSmFj8Is+TWqS+EfZ7Rsos9TMjeSloXDmGsJurHMqDoadVdXzUl+5iDE8XssI8bR/7vap+xTS1ZNUyzQxdzR8tm5WGuKckOpqEcIeXg2z/7khJAFDopTc73kksPa/psCm2T3P+vvKBirGePINfxfo87rct38WAjcCpEUOuWu9+MH3tZuXvhk3Q346Nq9GJycnTf9HOa6/Pf6LfJc6EVjcGxnog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HRuMF0Fp; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HRuMF0Fp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRRCM29pJz30MZ
	for <linux-erofs@lists.ozlabs.org>; Thu, 05 Mar 2026 21:50:39 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2EAEA4044A;
	Thu,  5 Mar 2026 10:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75396C116C6;
	Thu,  5 Mar 2026 10:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772707837;
	bh=u1CeJgjWd7kXPS3ws/muqknCR1bko0+rqrXMss6JWs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HRuMF0Fp5RgG+1TfOfSpoEQsuFnGiyxgpQaEJMycqoz5Lu0pxKWRIHueudja3BrrT
	 HS35EjVPfS42luoTz69IPj1Nb3BPZk5SG11K0m9+kjLyufD/DRqBU5HshDtwBR8mSX
	 gsx+fjzYBeNdInitBzNx4UXo7mbPJ8oDsH8QfGV5NU5hx4FQsbO7JCTL4pf05omubz
	 ZQkKT8PDabVcStINMOWLvo5KiCf6qtq8MJr2RPBXSMAbhDCDKCblz0q6XdEGUlEL20
	 81nqJV1Zevw5akClENINw2E3tAsDKSh/e4G3fS5T33Kukft3x9LbCsEoPR4Ck60mdd
	 CS2X0Ksy9gaWw==
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-mm@kvack.org,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/6] mm: add vma_desc_test_all() and use it
Date: Thu,  5 Mar 2026 10:50:15 +0000
Message-ID: <568c8f8d6a84ff64014f997517cba7a629f7eed6.1772704455.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772704455.git.ljs@kernel.org>
References: <cover.1772704455.git.ljs@kernel.org>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 709EA20FFD5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2509-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[arndb.de,linuxfoundation.org,intel.com,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,linux.dev,suse.de,paragon-software.com,arm.com,amd.com,wdc.com,infradead.org,suse.cz,oracle.com,suse.com,ziepe.ca,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	FORGED_SENDER(0.00)[ljs@kernel.org,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[44];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:dan.j.williams@intel.com,m:vishal.l.verma@intel.com,m:dave.jiang@intel.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:muchun.song@linux.dev,m:osalvador@suse.de,m:david@kernel.org,m:almaz.alexandrovich@paragon-software.com,m:tony.luck@intel.com,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:dlemoal@kernel.org,m:naohiro.aota@wdc.com,m:jth@kernel.org,m:willy@infradead.org,m:jack@suse.cz,m:Liam.Howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:jannh@google.com,m:pfalcato@suse.de,m:jgg@ziepe.ca,m:linux-kernel@vger.kernel.org,m:nvdimm@lists.linux.dev,m:linux-cxl@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-mm@kvack.org,m:ntfs3@
 lists.linux.dev,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

erofs and zonefs are using vma_desc_test_any() twice to check whether all
of VMA_SHARED_BIT and VMA_MAYWRITE_BIT are set, this is silly, so add
vma_desc_test_all() to test all flags and update erofs and zonefs to use
it.

While we're here, update the helper function comments to be more
consistent.

Also add the same to the VMA test headers.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 fs/erofs/data.c                 |  3 +--
 fs/zonefs/file.c                |  3 +--
 include/linux/mm.h              | 24 ++++++++++++++++++++----
 tools/testing/vma/include/dup.h |  9 +++++++++
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6774d9b5ee82..b33dd4d8710e 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -473,8 +473,7 @@ static int erofs_file_mmap_prepare(struct vm_area_desc *desc)
 	if (!IS_DAX(file_inode(desc->file)))
 		return generic_file_readonly_mmap_prepare(desc);
 
-	if (vma_desc_test_any(desc, VMA_SHARED_BIT) &&
-	    vma_desc_test_any(desc, VMA_MAYWRITE_BIT))
+	if (vma_desc_test_all(desc, VMA_SHARED_BIT, VMA_MAYWRITE_BIT))
 		return -EINVAL;
 
 	desc->vm_ops = &erofs_dax_vm_ops;
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 9f9273ecf71a..5ada33f70bb4 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -333,8 +333,7 @@ static int zonefs_file_mmap_prepare(struct vm_area_desc *desc)
 	 * ordering between msync() and page cache writeback.
 	 */
 	if (zonefs_inode_is_seq(file_inode(file)) &&
-	    vma_desc_test_any(desc, VMA_SHARED_BIT) &&
-	    vma_desc_test_any(desc, VMA_MAYWRITE_BIT))
+	    vma_desc_test_all(desc, VMA_SHARED_BIT, VMA_MAYWRITE_BIT))
 		return -EINVAL;
 
 	file_accessed(file);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index db738a567637..9a052eedcdf4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1178,7 +1178,7 @@ static inline void vma_set_flags_mask(struct vm_area_struct *vma,
 #define vma_set_flags(vma, ...) \
 	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
 
-/* Helper to test all VMA flags in a VMA descriptor. */
+/* Helper to test any VMA flags in a VMA descriptor. */
 static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
 		vma_flags_t flags)
 {
@@ -1186,8 +1186,8 @@ static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
 }
 
 /*
- * Helper macro for testing VMA flags for an input pointer to a struct
- * vm_area_desc object describing a proposed VMA, e.g.:
+ * Helper macro for testing whether any VMA flags are set in a VMA descriptor,
+ * e.g.:
  *
  * if (vma_desc_test_any(desc, VMA_IO_BIT, VMA_PFNMAP_BIT,
  *		VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT)) { ... }
@@ -1195,6 +1195,22 @@ static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
 #define vma_desc_test_any(desc, ...) \
 	vma_desc_test_any_mask(desc, mk_vma_flags(__VA_ARGS__))
 
+/* Helper to test all VMA flags in a VMA descriptor. */
+static inline bool vma_desc_test_all_mask(const struct vm_area_desc *desc,
+		vma_flags_t flags)
+{
+	return vma_flags_test_all_mask(&desc->vma_flags, flags);
+}
+
+/*
+ * Helper macro for testing whether ALL VMA flags are set in a VMA descriptor,
+ * e.g.:
+ *
+ * if (vma_desc_test_all(desc, VMA_READ_BIT, VMA_MAYREAD_BIT)) { ... }
+ */
+#define vma_desc_test_all(desc, ...) \
+	vma_desc_test_all_mask(desc, mk_vma_flags(__VA_ARGS__))
+
 /* Helper to set all VMA flags in a VMA descriptor. */
 static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
 		vma_flags_t flags)
@@ -1207,7 +1223,7 @@ static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
  * vm_area_desc object describing a proposed VMA, e.g.:
  *
  * vma_desc_set_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
- * 		VMA_DONTDUMP_BIT);
+ *		VMA_DONTDUMP_BIT);
  */
 #define vma_desc_set_flags(desc, ...) \
 	vma_desc_set_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index c46b523e428d..59788bc14d75 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -922,6 +922,15 @@ static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
 #define vma_desc_test_any(desc, ...) \
 	vma_desc_test_any_mask(desc, mk_vma_flags(__VA_ARGS__))
 
+static inline bool vma_desc_test_all_mask(const struct vm_area_desc *desc,
+		vma_flags_t flags)
+{
+	return vma_flags_test_all_mask(&desc->vma_flags, flags);
+}
+
+#define vma_desc_test_all(desc, ...) \
+	vma_desc_test_all_mask(desc, mk_vma_flags(__VA_ARGS__))
+
 static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
 					   vma_flags_t flags)
 {
-- 
2.53.0


