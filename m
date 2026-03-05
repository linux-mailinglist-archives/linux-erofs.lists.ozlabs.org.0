Return-Path: <linux-erofs+bounces-2508-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJoxNAFgqWnj6QAAu9opvQ
	(envelope-from <linux-erofs+bounces-2508-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 11:50:41 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D9520FFC8
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 11:50:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRRCK6Wd9z3c5j;
	Thu, 05 Mar 2026 21:50:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772707837;
	cv=none; b=Z2fHxvFOqIZ0q8Sx73UQ0jbDKKQXRCRXtKwRBZ7YrDe97T/MzPReOk9T8tzntQALnSfFKdoUC2g3sTuRH3OssCI+KmVe7BVOU5OfBwWbu58RtlyUl6iYyF1WEA5CPuxcj02clYadtzyigfFfS55x3yTzydRNJMVMLQlDwnUr9hetuaMxFw60j2c8Mai7mP87tnoJSNMI2YcmbmDdW0X4VnLfQYEJbaeas5CVxAV7CamHz2pEWzA94o8O+20MeIAkX/TzkqwcYwzUEUxdheWV+9CTgMvVmF0jO423NcKghY8CKaarJfyd8/w72Pa5bbvKGmja+rlZR8UYwEN9YcpisA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772707837; c=relaxed/relaxed;
	bh=kCyI4PA7JaoGOFzj2pucgmTqnPoftyhBnbTY3EPClrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFYbwMkX33fgh4klSOH63zjOL4CzczLJ4YPVMfEXwQ8OSxzzqToaflm1N02MJpFIUphWEdoRGWXNMkdIZBQ2WtUduaju1F5byd9L20kR+A/dfki6xP93IIFqhMpULBEzYfn4Fk8+XzKZNYxV0K5BiqFkjcTHbHkPFyRPWxwGPF1t3TY4sbxfcyT3hYasHc6qoEM8gZ52jKo4yPsQUKM13zmq3SO2EuTHlw4TRYPwJVuPb5IaJdAwrFRtXCww5TmfBxe7qjDlNYvHA39UOTv/OClvHAvQmqamN/Q7f/Vdklk6jKgqYgOQAHg0Or/Nbv9txxcxleN6m1mXF8vNNAmxgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X++29/vP; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X++29/vP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRRCJ4SVsz30MZ
	for <linux-erofs@lists.ozlabs.org>; Thu, 05 Mar 2026 21:50:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 73AA161340;
	Thu,  5 Mar 2026 10:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D95C116C6;
	Thu,  5 Mar 2026 10:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772707834;
	bh=LZYuZlveZInJUx0Ltpa7Edi8PcbZMXZcw5f8+0KB4hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X++29/vP75Gp4H+cKqv0ViP85UAT9FzxFk1U7JW1/EJ57duWTMbyzNKWaMW87khNk
	 OM3Aou/BSjR/C1yVXDox4eAFL5ICaUmKMTw+zaSdk+/HytgEsnigwmKnwXLZvq4Cei
	 XKQ9KxLZC1kXiwSDN6KcPFG/SdP6JGQA0HcqVZ7I0rtbTD+LWoxL0iaKmb/L74EtF5
	 mv3mQN2aEnvVI9RgwbHkc/3uy5YtlBnRt69eVqrYeZQgPVU+S8cLadWyrvOWtYQQxE
	 kne6AhAZ57Zr7WHGG2CpImfpZaEPejJHHN1mnmBdo+1/qQtRhgCubRD6kbOJ+VH4sZ
	 1p2zZLuIW3+JQ==
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
Subject: [PATCH 1/6] mm: rename VMA flag helpers to be more readable
Date: Thu,  5 Mar 2026 10:50:14 +0000
Message-ID: <0f9cb3c511c478344fac0b3b3b0300bb95be95e9.1772704455.git.ljs@kernel.org>
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
X-Rspamd-Queue-Id: C7D9520FFC8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2508-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,suse.de:email]
X-Rspamd-Action: no action

On reflection, it's confusing to have vma_flags_test() and
vma_desc_test_flags() test whether any comma-separated VMA flag bit is set,
while also having vma_flags_test_all() and vma_test_all_flags() separately
test whether all flags are set.

Firstly, rename vma_flags_test() to vma_flags_test_any() to eliminate this
confusion.

Secondly, since the VMA descriptor flag functions are becoming rather
cumbersome, prefer vma_desc_test*() to vma_desc_test_flags*(), and also
rename vma_desc_test_flags() to vma_desc_test_any().

Finally, rename vma_test_all_flags() to vma_test_all() to keep the
VMA-specific helper consistent with the VMA descriptor naming convention
and to help avoid confusion vs. vma_flags_test_all().

While we're here, also update whitespace to be consistent in helper
functions.

Suggested-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 drivers/char/mem.c              |  2 +-
 drivers/dax/device.c            |  2 +-
 fs/erofs/data.c                 |  4 +--
 fs/hugetlbfs/inode.c            |  2 +-
 fs/ntfs3/file.c                 |  2 +-
 fs/resctrl/pseudo_lock.c        |  2 +-
 fs/zonefs/file.c                |  4 +--
 include/linux/dax.h             |  4 +--
 include/linux/hugetlb_inline.h  |  2 +-
 include/linux/mm.h              | 48 +++++++++++++++++----------------
 mm/hugetlb.c                    | 14 +++++-----
 mm/memory.c                     |  2 +-
 mm/secretmem.c                  |  2 +-
 mm/shmem.c                      |  4 +--
 tools/testing/vma/include/dup.h | 20 +++++++-------
 tools/testing/vma/tests/vma.c   | 28 +++++++++----------
 16 files changed, 72 insertions(+), 70 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index cca4529431f8..5118787d0954 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -520,7 +520,7 @@ static int mmap_zero_prepare(struct vm_area_desc *desc)
 #ifndef CONFIG_MMU
 	return -ENOSYS;
 #endif
-	if (vma_desc_test_flags(desc, VMA_SHARED_BIT))
+	if (vma_desc_test_any(desc, VMA_SHARED_BIT))
 		return shmem_zero_setup_desc(desc);
 
 	desc->action.success_hook = mmap_zero_private_success;
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 528e81240c4d..381021c2e031 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -24,7 +24,7 @@ static int __check_vma(struct dev_dax *dev_dax, vma_flags_t flags,
 		return -ENXIO;
 
 	/* prevent private mappings from being established */
-	if (!vma_flags_test(&flags, VMA_MAYSHARE_BIT)) {
+	if (!vma_flags_test_any(&flags, VMA_MAYSHARE_BIT)) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, attempted private mapping\n",
 				current->comm, func);
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index f79ee80627d9..6774d9b5ee82 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -473,8 +473,8 @@ static int erofs_file_mmap_prepare(struct vm_area_desc *desc)
 	if (!IS_DAX(file_inode(desc->file)))
 		return generic_file_readonly_mmap_prepare(desc);
 
-	if (vma_desc_test_flags(desc, VMA_SHARED_BIT) &&
-	    vma_desc_test_flags(desc, VMA_MAYWRITE_BIT))
+	if (vma_desc_test_any(desc, VMA_SHARED_BIT) &&
+	    vma_desc_test_any(desc, VMA_MAYWRITE_BIT))
 		return -EINVAL;
 
 	desc->vm_ops = &erofs_dax_vm_ops;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 2ec3e4231252..079ffaaf1f6c 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -164,7 +164,7 @@ static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
 		goto out;
 
 	ret = 0;
-	if (vma_desc_test_flags(desc, VMA_WRITE_BIT) && inode->i_size < len)
+	if (vma_desc_test_any(desc, VMA_WRITE_BIT) && inode->i_size < len)
 		i_size_write(inode, len);
 out:
 	inode_unlock(inode);
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 7eecf1e01f74..c5e2181f9f02 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -276,7 +276,7 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 	struct file *file = desc->file;
 	struct inode *inode = file_inode(file);
 	struct ntfs_inode *ni = ntfs_i(inode);
-	const bool rw = vma_desc_test_flags(desc, VMA_WRITE_BIT);
+	const bool rw = vma_desc_test_any(desc, VMA_WRITE_BIT);
 	int err;
 
 	/* Avoid any operation if inode is bad. */
diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index fa3687d69ebd..79a006c6f26c 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -1044,7 +1044,7 @@ static int pseudo_lock_dev_mmap_prepare(struct vm_area_desc *desc)
 	 * Ensure changes are carried directly to the memory being mapped,
 	 * do not allow copy-on-write mapping.
 	 */
-	if (!vma_desc_test_flags(desc, VMA_SHARED_BIT)) {
+	if (!vma_desc_test_any(desc, VMA_SHARED_BIT)) {
 		mutex_unlock(&rdtgroup_mutex);
 		return -EINVAL;
 	}
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 8a7161fc49e5..9f9273ecf71a 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -333,8 +333,8 @@ static int zonefs_file_mmap_prepare(struct vm_area_desc *desc)
 	 * ordering between msync() and page cache writeback.
 	 */
 	if (zonefs_inode_is_seq(file_inode(file)) &&
-	    vma_desc_test_flags(desc, VMA_SHARED_BIT) &&
-	    vma_desc_test_flags(desc, VMA_MAYWRITE_BIT))
+	    vma_desc_test_any(desc, VMA_SHARED_BIT) &&
+	    vma_desc_test_any(desc, VMA_MAYWRITE_BIT))
 		return -EINVAL;
 
 	file_accessed(file);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index bf103f317cac..535019001577 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -69,7 +69,7 @@ static inline bool daxdev_mapping_supported(const struct vm_area_desc *desc,
 					    const struct inode *inode,
 					    struct dax_device *dax_dev)
 {
-	if (!vma_desc_test_flags(desc, VMA_SYNC_BIT))
+	if (!vma_desc_test_any(desc, VMA_SYNC_BIT))
 		return true;
 	if (!IS_DAX(inode))
 		return false;
@@ -115,7 +115,7 @@ static inline bool daxdev_mapping_supported(const struct vm_area_desc *desc,
 					    const struct inode *inode,
 					    struct dax_device *dax_dev)
 {
-	return !vma_desc_test_flags(desc, VMA_SYNC_BIT);
+	return !vma_desc_test_any(desc, VMA_SYNC_BIT);
 }
 static inline size_t dax_recovery_write(struct dax_device *dax_dev,
 		pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i)
diff --git a/include/linux/hugetlb_inline.h b/include/linux/hugetlb_inline.h
index 593f5d4e108b..84afc3c3e2e4 100644
--- a/include/linux/hugetlb_inline.h
+++ b/include/linux/hugetlb_inline.h
@@ -13,7 +13,7 @@ static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
 
 static inline bool is_vma_hugetlb_flags(const vma_flags_t *flags)
 {
-	return vma_flags_test(flags, VMA_HUGETLB_BIT);
+	return vma_flags_test_any(flags, VMA_HUGETLB_BIT);
 }
 
 #else
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1e2af6810f96..db738a567637 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1063,7 +1063,7 @@ static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
 					 (const vma_flag_t []){__VA_ARGS__})
 
 /*  Test each of to_test flags in flags, non-atomically. */
-static __always_inline bool vma_flags_test_mask(const vma_flags_t *flags,
+static __always_inline bool vma_flags_test_any_mask(const vma_flags_t *flags,
 		vma_flags_t to_test)
 {
 	const unsigned long *bitmap = flags->__vma_flags;
@@ -1075,10 +1075,10 @@ static __always_inline bool vma_flags_test_mask(const vma_flags_t *flags,
 /*
  * Test whether any specified VMA flag is set, e.g.:
  *
- * if (vma_flags_test(flags, VMA_READ_BIT, VMA_MAYREAD_BIT)) { ... }
+ * if (vma_flags_test_any(flags, VMA_READ_BIT, VMA_MAYREAD_BIT)) { ... }
  */
-#define vma_flags_test(flags, ...) \
-	vma_flags_test_mask(flags, mk_vma_flags(__VA_ARGS__))
+#define vma_flags_test_any(flags, ...) \
+	vma_flags_test_any_mask(flags, mk_vma_flags(__VA_ARGS__))
 
 /* Test that ALL of the to_test flags are set, non-atomically. */
 static __always_inline bool vma_flags_test_all_mask(const vma_flags_t *flags,
@@ -1099,7 +1099,8 @@ static __always_inline bool vma_flags_test_all_mask(const vma_flags_t *flags,
 	vma_flags_test_all_mask(flags, mk_vma_flags(__VA_ARGS__))
 
 /* Set each of the to_set flags in flags, non-atomically. */
-static __always_inline void vma_flags_set_mask(vma_flags_t *flags, vma_flags_t to_set)
+static __always_inline void vma_flags_set_mask(vma_flags_t *flags,
+		vma_flags_t to_set)
 {
 	unsigned long *bitmap = flags->__vma_flags;
 	const unsigned long *bitmap_to_set = to_set.__vma_flags;
@@ -1116,7 +1117,8 @@ static __always_inline void vma_flags_set_mask(vma_flags_t *flags, vma_flags_t t
 	vma_flags_set_mask(flags, mk_vma_flags(__VA_ARGS__))
 
 /* Clear all of the to-clear flags in flags, non-atomically. */
-static __always_inline void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t to_clear)
+static __always_inline void vma_flags_clear_mask(vma_flags_t *flags,
+		vma_flags_t to_clear)
 {
 	unsigned long *bitmap = flags->__vma_flags;
 	const unsigned long *bitmap_to_clear = to_clear.__vma_flags;
@@ -1138,8 +1140,8 @@ static __always_inline void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t
  * Note: appropriate locks must be held, this function does not acquire them for
  * you.
  */
-static inline bool vma_test_all_flags_mask(const struct vm_area_struct *vma,
-					   vma_flags_t flags)
+static inline bool vma_test_all_mask(const struct vm_area_struct *vma,
+		vma_flags_t flags)
 {
 	return vma_flags_test_all_mask(&vma->flags, flags);
 }
@@ -1147,10 +1149,10 @@ static inline bool vma_test_all_flags_mask(const struct vm_area_struct *vma,
 /*
  * Helper macro for checking that ALL specified flags are set in a VMA, e.g.:
  *
- * if (vma_test_all_flags(vma, VMA_READ_BIT, VMA_MAYREAD_BIT) { ... }
+ * if (vma_test_all(vma, VMA_READ_BIT, VMA_MAYREAD_BIT) { ... }
  */
-#define vma_test_all_flags(vma, ...) \
-	vma_test_all_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+#define vma_test_all(vma, ...) \
+	vma_test_all_mask(vma, mk_vma_flags(__VA_ARGS__))
 
 /*
  * Helper to set all VMA flags in a VMA.
@@ -1159,7 +1161,7 @@ static inline bool vma_test_all_flags_mask(const struct vm_area_struct *vma,
  * you.
  */
 static inline void vma_set_flags_mask(struct vm_area_struct *vma,
-				      vma_flags_t flags)
+		vma_flags_t flags)
 {
 	vma_flags_set_mask(&vma->flags, flags);
 }
@@ -1177,25 +1179,25 @@ static inline void vma_set_flags_mask(struct vm_area_struct *vma,
 	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
 
 /* Helper to test all VMA flags in a VMA descriptor. */
-static inline bool vma_desc_test_flags_mask(const struct vm_area_desc *desc,
-					    vma_flags_t flags)
+static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
+		vma_flags_t flags)
 {
-	return vma_flags_test_mask(&desc->vma_flags, flags);
+	return vma_flags_test_any_mask(&desc->vma_flags, flags);
 }
 
 /*
  * Helper macro for testing VMA flags for an input pointer to a struct
  * vm_area_desc object describing a proposed VMA, e.g.:
  *
- * if (vma_desc_test_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT,
+ * if (vma_desc_test_any(desc, VMA_IO_BIT, VMA_PFNMAP_BIT,
  *		VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT)) { ... }
  */
-#define vma_desc_test_flags(desc, ...) \
-	vma_desc_test_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+#define vma_desc_test_any(desc, ...) \
+	vma_desc_test_any_mask(desc, mk_vma_flags(__VA_ARGS__))
 
 /* Helper to set all VMA flags in a VMA descriptor. */
 static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
-					   vma_flags_t flags)
+		vma_flags_t flags)
 {
 	vma_flags_set_mask(&desc->vma_flags, flags);
 }
@@ -1212,7 +1214,7 @@ static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
 
 /* Helper to clear all VMA flags in a VMA descriptor. */
 static inline void vma_desc_clear_flags_mask(struct vm_area_desc *desc,
-					     vma_flags_t flags)
+		vma_flags_t flags)
 {
 	vma_flags_clear_mask(&desc->vma_flags, flags);
 }
@@ -1937,8 +1939,8 @@ static inline bool vma_desc_is_cow_mapping(struct vm_area_desc *desc)
 {
 	const vma_flags_t *flags = &desc->vma_flags;
 
-	return vma_flags_test(flags, VMA_MAYWRITE_BIT) &&
-		!vma_flags_test(flags, VMA_SHARED_BIT);
+	return vma_flags_test_any(flags, VMA_MAYWRITE_BIT) &&
+		!vma_flags_test_any(flags, VMA_SHARED_BIT);
 }
 
 #ifndef CONFIG_MMU
@@ -1957,7 +1959,7 @@ static inline bool is_nommu_shared_mapping(vm_flags_t flags)
 
 static inline bool is_nommu_shared_vma_flags(const vma_flags_t *flags)
 {
-	return vma_flags_test(flags, VMA_MAYSHARE_BIT, VMA_MAYOVERLAY_BIT);
+	return vma_flags_test_any(flags, VMA_MAYSHARE_BIT, VMA_MAYOVERLAY_BIT);
 }
 #endif
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 327eaa4074d3..8286c5db2c12 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1194,7 +1194,7 @@ static void set_vma_resv_flags(struct vm_area_struct *vma, unsigned long flags)
 static void set_vma_desc_resv_map(struct vm_area_desc *desc, struct resv_map *map)
 {
 	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(&desc->vma_flags));
-	VM_WARN_ON_ONCE(vma_desc_test_flags(desc, VMA_MAYSHARE_BIT));
+	VM_WARN_ON_ONCE(vma_desc_test_any(desc, VMA_MAYSHARE_BIT));
 
 	desc->private_data = map;
 }
@@ -1202,7 +1202,7 @@ static void set_vma_desc_resv_map(struct vm_area_desc *desc, struct resv_map *ma
 static void set_vma_desc_resv_flags(struct vm_area_desc *desc, unsigned long flags)
 {
 	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(&desc->vma_flags));
-	VM_WARN_ON_ONCE(vma_desc_test_flags(desc, VMA_MAYSHARE_BIT));
+	VM_WARN_ON_ONCE(vma_desc_test_any(desc, VMA_MAYSHARE_BIT));
 
 	desc->private_data = (void *)((unsigned long)desc->private_data | flags);
 }
@@ -6591,7 +6591,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * attempt will be made for VM_NORESERVE to allocate a page
 	 * without using reserves
 	 */
-	if (vma_flags_test(&vma_flags, VMA_NORESERVE_BIT))
+	if (vma_flags_test_any(&vma_flags, VMA_NORESERVE_BIT))
 		return 0;
 
 	/*
@@ -6600,7 +6600,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * to reserve the full area even if read-only as mprotect() may be
 	 * called to make the mapping read-write. Assume !desc is a shm mapping
 	 */
-	if (!desc || vma_desc_test_flags(desc, VMA_MAYSHARE_BIT)) {
+	if (!desc || vma_desc_test_any(desc, VMA_MAYSHARE_BIT)) {
 		/*
 		 * resv_map can not be NULL as hugetlb_reserve_pages is only
 		 * called for inodes for which resv_maps were created (see
@@ -6634,7 +6634,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	if (err < 0)
 		goto out_err;
 
-	if (desc && !vma_desc_test_flags(desc, VMA_MAYSHARE_BIT) && h_cg) {
+	if (desc && !vma_desc_test_any(desc, VMA_MAYSHARE_BIT) && h_cg) {
 		/* For private mappings, the hugetlb_cgroup uncharge info hangs
 		 * of the resv_map.
 		 */
@@ -6671,7 +6671,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * consumed reservations are stored in the map. Hence, nothing
 	 * else has to be done for private mappings here
 	 */
-	if (!desc || vma_desc_test_flags(desc, VMA_MAYSHARE_BIT)) {
+	if (!desc || vma_desc_test_any(desc, VMA_MAYSHARE_BIT)) {
 		add = region_add(resv_map, from, to, regions_needed, h, h_cg);
 
 		if (unlikely(add < 0)) {
@@ -6735,7 +6735,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
 out_err:
-	if (!desc || vma_desc_test_flags(desc, VMA_MAYSHARE_BIT))
+	if (!desc || vma_desc_test_any(desc, VMA_MAYSHARE_BIT))
 		/* Only call region_abort if the region_chg succeeded but the
 		 * region_add failed or didn't run.
 		 */
diff --git a/mm/memory.c b/mm/memory.c
index 9385842c3503..1d321acb1e50 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2969,7 +2969,7 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr)))
 		return -EINVAL;
 
-	VM_WARN_ON_ONCE(!vma_test_all_flags_mask(vma, VMA_REMAP_FLAGS));
+	VM_WARN_ON_ONCE(!vma_test_all_mask(vma, VMA_REMAP_FLAGS));
 
 	BUG_ON(addr >= end);
 	pfn -= addr >> PAGE_SHIFT;
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 11a779c812a7..5f57ac4720d3 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -122,7 +122,7 @@ static int secretmem_mmap_prepare(struct vm_area_desc *desc)
 {
 	const unsigned long len = vma_desc_size(desc);
 
-	if (!vma_desc_test_flags(desc, VMA_SHARED_BIT, VMA_MAYSHARE_BIT))
+	if (!vma_desc_test_any(desc, VMA_SHARED_BIT, VMA_MAYSHARE_BIT))
 		return -EINVAL;
 
 	vma_desc_set_flags(desc, VMA_LOCKED_BIT, VMA_DONTDUMP_BIT);
diff --git a/mm/shmem.c b/mm/shmem.c
index 5e7dcf5bc5d3..965a8908200b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3086,7 +3086,7 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	spin_lock_init(&info->lock);
 	atomic_set(&info->stop_eviction, 0);
 	info->seals = F_SEAL_SEAL;
-	info->flags = vma_flags_test(&flags, VMA_NORESERVE_BIT)
+	info->flags = vma_flags_test_any(&flags, VMA_NORESERVE_BIT)
 		? SHMEM_F_NORESERVE : 0;
 	info->i_crtime = inode_get_mtime(inode);
 	info->fsflags = (dir == NULL) ? 0 :
@@ -5827,7 +5827,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
 				       unsigned int i_flags)
 {
 	const unsigned long shmem_flags =
-		vma_flags_test(&flags, VMA_NORESERVE_BIT) ? SHMEM_F_NORESERVE : 0;
+		vma_flags_test_any(&flags, VMA_NORESERVE_BIT) ? SHMEM_F_NORESERVE : 0;
 	struct inode *inode;
 	struct file *res;
 
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 3078ff1487d3..c46b523e428d 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -843,7 +843,7 @@ static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits);
 #define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
 					 (const vma_flag_t []){__VA_ARGS__})
 
-static __always_inline bool vma_flags_test_mask(const vma_flags_t *flags,
+static __always_inline bool vma_flags_test_any_mask(const vma_flags_t *flags,
 		vma_flags_t to_test)
 {
 	const unsigned long *bitmap = flags->__vma_flags;
@@ -852,8 +852,8 @@ static __always_inline bool vma_flags_test_mask(const vma_flags_t *flags,
 	return bitmap_intersects(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
 }
 
-#define vma_flags_test(flags, ...) \
-	vma_flags_test_mask(flags, mk_vma_flags(__VA_ARGS__))
+#define vma_flags_test_any(flags, ...) \
+	vma_flags_test_any_mask(flags, mk_vma_flags(__VA_ARGS__))
 
 static __always_inline bool vma_flags_test_all_mask(const vma_flags_t *flags,
 		vma_flags_t to_test)
@@ -889,14 +889,14 @@ static __always_inline void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t
 #define vma_flags_clear(flags, ...) \
 	vma_flags_clear_mask(flags, mk_vma_flags(__VA_ARGS__))
 
-static inline bool vma_test_all_flags_mask(const struct vm_area_struct *vma,
+static inline bool vma_test_all_mask(const struct vm_area_struct *vma,
 					   vma_flags_t flags)
 {
 	return vma_flags_test_all_mask(&vma->flags, flags);
 }
 
-#define vma_test_all_flags(vma, ...) \
-	vma_test_all_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+#define vma_test_all(vma, ...) \
+	vma_test_all_mask(vma, mk_vma_flags(__VA_ARGS__))
 
 static inline bool is_shared_maywrite_vm_flags(vm_flags_t vm_flags)
 {
@@ -913,14 +913,14 @@ static inline void vma_set_flags_mask(struct vm_area_struct *vma,
 #define vma_set_flags(vma, ...) \
 	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
 
-static inline bool vma_desc_test_flags_mask(const struct vm_area_desc *desc,
+static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
 					    vma_flags_t flags)
 {
-	return vma_flags_test_mask(&desc->vma_flags, flags);
+	return vma_flags_test_any_mask(&desc->vma_flags, flags);
 }
 
-#define vma_desc_test_flags(desc, ...) \
-	vma_desc_test_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+#define vma_desc_test_any(desc, ...) \
+	vma_desc_test_any_mask(desc, mk_vma_flags(__VA_ARGS__))
 
 static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
 					   vma_flags_t flags)
diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
index c54ffc954f11..f031e6dfb474 100644
--- a/tools/testing/vma/tests/vma.c
+++ b/tools/testing/vma/tests/vma.c
@@ -159,8 +159,8 @@ static bool test_vma_flags_word(void)
 	return true;
 }
 
-/* Ensure that vma_flags_test() and friends works correctly. */
-static bool test_vma_flags_test(void)
+/* Ensure that vma_flags_test_any() and friends works correctly. */
+static bool test_vma_flags_test_any(void)
 {
 	const vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
 					       VMA_EXEC_BIT, 64, 65);
@@ -171,16 +171,16 @@ static bool test_vma_flags_test(void)
 	desc.vma_flags = flags;
 
 #define do_test(...)						\
-	ASSERT_TRUE(vma_flags_test(&flags, __VA_ARGS__));	\
-	ASSERT_TRUE(vma_desc_test_flags(&desc, __VA_ARGS__))
+	ASSERT_TRUE(vma_flags_test_any(&flags, __VA_ARGS__));	\
+	ASSERT_TRUE(vma_desc_test_any(&desc, __VA_ARGS__))
 
 #define do_test_all_true(...)					\
 	ASSERT_TRUE(vma_flags_test_all(&flags, __VA_ARGS__));	\
-	ASSERT_TRUE(vma_test_all_flags(&vma, __VA_ARGS__))
+	ASSERT_TRUE(vma_test_all(&vma, __VA_ARGS__))
 
 #define do_test_all_false(...)					\
 	ASSERT_FALSE(vma_flags_test_all(&flags, __VA_ARGS__));	\
-	ASSERT_FALSE(vma_test_all_flags(&vma, __VA_ARGS__))
+	ASSERT_FALSE(vma_test_all(&vma, __VA_ARGS__))
 
 	/*
 	 * Testing for some flags that are present, some that are not - should
@@ -200,7 +200,7 @@ static bool test_vma_flags_test(void)
 	 * Check _mask variant. We don't need to test extensively as macro
 	 * helper is the equivalent.
 	 */
-	ASSERT_TRUE(vma_flags_test_mask(&flags, flags));
+	ASSERT_TRUE(vma_flags_test_any_mask(&flags, flags));
 	ASSERT_TRUE(vma_flags_test_all_mask(&flags, flags));
 
 	/* Single bits. */
@@ -268,9 +268,9 @@ static bool test_vma_flags_clear(void)
 	vma_flags_clear_mask(&flags, mask);
 	vma_flags_clear_mask(&vma.flags, mask);
 	vma_desc_clear_flags_mask(&desc, mask);
-	ASSERT_FALSE(vma_flags_test(&flags, VMA_EXEC_BIT, 64));
-	ASSERT_FALSE(vma_flags_test(&vma.flags, VMA_EXEC_BIT, 64));
-	ASSERT_FALSE(vma_desc_test_flags(&desc, VMA_EXEC_BIT, 64));
+	ASSERT_FALSE(vma_flags_test_any(&flags, VMA_EXEC_BIT, 64));
+	ASSERT_FALSE(vma_flags_test_any(&vma.flags, VMA_EXEC_BIT, 64));
+	ASSERT_FALSE(vma_desc_test_any(&desc, VMA_EXEC_BIT, 64));
 	/* Reset. */
 	vma_flags_set(&flags, VMA_EXEC_BIT, 64);
 	vma_set_flags(&vma, VMA_EXEC_BIT, 64);
@@ -284,9 +284,9 @@ static bool test_vma_flags_clear(void)
 	vma_flags_clear(&flags, __VA_ARGS__);			\
 	vma_flags_clear(&vma.flags, __VA_ARGS__);		\
 	vma_desc_clear_flags(&desc, __VA_ARGS__);		\
-	ASSERT_FALSE(vma_flags_test(&flags, __VA_ARGS__));	\
-	ASSERT_FALSE(vma_flags_test(&vma.flags, __VA_ARGS__));	\
-	ASSERT_FALSE(vma_desc_test_flags(&desc, __VA_ARGS__));	\
+	ASSERT_FALSE(vma_flags_test_any(&flags, __VA_ARGS__));	\
+	ASSERT_FALSE(vma_flags_test_any(&vma.flags, __VA_ARGS__));	\
+	ASSERT_FALSE(vma_desc_test_any(&desc, __VA_ARGS__));	\
 	vma_flags_set(&flags, __VA_ARGS__);			\
 	vma_set_flags(&vma, __VA_ARGS__);			\
 	vma_desc_set_flags(&desc, __VA_ARGS__)
@@ -334,6 +334,6 @@ static void run_vma_tests(int *num_tests, int *num_fail)
 	TEST(vma_flags_unchanged);
 	TEST(vma_flags_cleared);
 	TEST(vma_flags_word);
-	TEST(vma_flags_test);
+	TEST(vma_flags_test_any);
 	TEST(vma_flags_clear);
 }
-- 
2.53.0


