Return-Path: <linux-erofs+bounces-2510-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOX7NgZgqWlc6QAAu9opvQ
	(envelope-from <linux-erofs+bounces-2510-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 11:50:46 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED0F20FFDC
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 11:50:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRRCQ5Q9Rz3c8h;
	Thu, 05 Mar 2026 21:50:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772707842;
	cv=none; b=UeVCQjtuYS+2T+SPZ0NsinCyufOX2SoEPmmvqi4YUJaIDM+O/Bg5J+2xz9n9iCiwLxjxg4k/ec67Y6Q4zXyDSGe+j+Z6K9hzzwYbW4GamJ67/hfiOgyEVMPPg/8d6JlIgE17h4VhfjyREn/OMu9u/QOeWqM51z752Y0vc+Cfd1GVdhkr71cijvqjxQFoes3ZUb5TLVPRrSY+LpJXp9Uf/j66nXWwK6xRIy1fHcIoAJCA31IhnZjbwgnq+GJOuWWs53Ns4mec2k7/oAGQcSGEo/ZAAOZn9zq43zEhANkPVYOBuDDWk7htZXlix+zX1N44S2mat0f5iDPeGjO9g8pFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772707842; c=relaxed/relaxed;
	bh=+05H/PICBvxhE8fZbU0wd74IdRVKUUETjgpVxIwFBJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuNak6tdsC6k9ztZG389FAQAyhicmcNeDXEipZIshlmMmscsUv+dyHeSgOXIOzbWck/36ZdN7E2q9/gL8jWh1phOplBd2uw+45WpajVYUJiFm80ZSvI3GsWUesvXN23z/MhVX7CUw95Pg/oiGHwdX2bCXKOhiMUJgGSxUbvyYyXZdVbvpuuDwtoFzW2LZLsay0+UTrY4eOxO9ynMednNL2+/y7p1hJvsA3J9cOgjZDwzgeIjFdFWTlQMDg37moQDxTIIwVsTlh5uwMvxr1REAIIFU3bX/yIhFt9ogcGmQgJFTwLfwPCbT0CnjTpAH+PRVs6o29666IKG/jB9kkbsiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qzRe592d; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qzRe592d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRRCP727Pz30MZ
	for <linux-erofs@lists.ozlabs.org>; Thu, 05 Mar 2026 21:50:41 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2C3AD6183E;
	Thu,  5 Mar 2026 10:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B328C2BCB2;
	Thu,  5 Mar 2026 10:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772707839;
	bh=DYhXxlFibg/ph+ULNrBqyx61MpJC3w0/qL0oDFFaj48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qzRe592dIXMITxgi3/PMgCbLgnQE+I+PwMx0WtLY14sm0eiu04iJcrc8TQhUREmTw
	 pMUJVal4HNAiq1fs/UAY0/7GXh6sQzdNTGwpgGUnbBmhLhbeTp7nW342JH2E3TZsK2
	 QL52Vs6CB2ZADgGsvLkubcObTuz+czHasN1nAmuooUDg3xLhM4mkM6awtLec9H2q0o
	 R2nKhYT/awx8tr7NJjxrObPoyneblu4xJB0rwFgvYAXDpDaz1T2DOCgRZrzDZ0ZyCc
	 XcXhwWR/vWuMnRpspwy0ytUtb6G2tLgQ4NJhINCnUElVjKMQQHfwTfahU2F9VbnbQQ
	 PbvCFCm3KZCJQ==
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
Subject: [PATCH 3/6] mm: always inline __mk_vma_flags() and invoked functions
Date: Thu,  5 Mar 2026 10:50:16 +0000
Message-ID: <241f49c52074d436edbb9c6a6662a8dc142a8f43.1772704455.git.ljs@kernel.org>
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
X-Rspamd-Queue-Id: 3ED0F20FFDC
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
	TAGGED_FROM(0.00)[bounces-2510-lists,linux-erofs=lfdr.de];
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

Be explicit about __mk_vma_flags() (which is used by the mk_vma_flags()
macro) always being inline, as we rely on the compiler converting this
function into meaningful.

Also update all of the functions __mk_vma_flags() ultimately invokes to be
always inline too.

Note that test_bitmap_const_eval() asserts that the relevant bitmap
functions result in build time constant values.

Additionally, vma_flag_set() operates on a vma_flags_t type, so it is
inconsistently named versus other VMA flags functions.

We only use vma_flag_set() in __mk_vma_flags() so we don't need to worry
about its new name being rather cumbersome, so rename it to
vma_flags_set_flag() to disambiguate it from vma_flags_set().

Also update the VMA test headers to reflect the changes.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 include/linux/mm.h                 | 8 +++++---
 include/linux/mm_types.h           | 2 +-
 tools/testing/vma/include/custom.h | 5 +++--
 tools/testing/vma/include/dup.h    | 5 +++--
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9a052eedcdf4..66b90de30bf6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1031,21 +1031,23 @@ static inline bool vma_test_atomic_flag(struct vm_area_struct *vma, vma_flag_t b
 }
 
 /* Set an individual VMA flag in flags, non-atomically. */
-static inline void vma_flag_set(vma_flags_t *flags, vma_flag_t bit)
+static __always_inline void vma_flags_set_flag(vma_flags_t *flags,
+		vma_flag_t bit)
 {
 	unsigned long *bitmap = flags->__vma_flags;
 
 	__set_bit((__force int)bit, bitmap);
 }
 
-static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
+static __always_inline vma_flags_t __mk_vma_flags(size_t count,
+		const vma_flag_t *bits)
 {
 	vma_flags_t flags;
 	int i;
 
 	vma_flags_clear_all(&flags);
 	for (i = 0; i < count; i++)
-		vma_flag_set(&flags, bits[i]);
+		vma_flags_set_flag(&flags, bits[i]);
 	return flags;
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1a808d78245d..294efc22b2a4 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1056,7 +1056,7 @@ struct vm_area_struct {
 } __randomize_layout;
 
 /* Clears all bits in the VMA flags bitmap, non-atomically. */
-static inline void vma_flags_clear_all(vma_flags_t *flags)
+static __always_inline void vma_flags_clear_all(vma_flags_t *flags)
 {
 	bitmap_zero(flags->__vma_flags, NUM_VMA_FLAG_BITS);
 }
diff --git a/tools/testing/vma/include/custom.h b/tools/testing/vma/include/custom.h
index 802a76317245..833ff4d7f799 100644
--- a/tools/testing/vma/include/custom.h
+++ b/tools/testing/vma/include/custom.h
@@ -102,7 +102,8 @@ static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
 		refcount_set(&vma->vm_refcnt, 0);
 }
 
-static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
+static __always_inline vma_flags_t __mk_vma_flags(size_t count,
+		const vma_flag_t *bits)
 {
 	vma_flags_t flags;
 	int i;
@@ -114,6 +115,6 @@ static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
 	vma_flags_clear_all(&flags);
 	for (i = 0; i < count; i++)
 		if (bits[i] < NUM_VMA_FLAG_BITS)
-			vma_flag_set(&flags, bits[i]);
+			vma_flags_set_flag(&flags, bits[i]);
 	return flags;
 }
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 59788bc14d75..ef6b9d963acc 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -780,12 +780,13 @@ static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
 	*bitmap &= ~value;
 }
 
-static inline void vma_flags_clear_all(vma_flags_t *flags)
+static __always_inline void vma_flags_clear_all(vma_flags_t *flags)
 {
 	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
 }
 
-static inline void vma_flag_set(vma_flags_t *flags, vma_flag_t bit)
+static __always_inline void vma_flags_set_flag(vma_flags_t *flags,
+		vma_flag_t bit)
 {
 	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
 
-- 
2.53.0


