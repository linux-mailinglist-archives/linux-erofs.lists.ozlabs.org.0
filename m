Return-Path: <linux-erofs+bounces-929-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2631CB38E98
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Aug 2025 00:43:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cC01W458dz2xcD;
	Thu, 28 Aug 2025 08:43:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::104a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756334607;
	cv=none; b=P7pSX5nVD9z/DQE7JendNn9EqJdyzVNiO9RliNnFHJgUy70niVuyuSPkKqd1Veyr/unPjtbf5ODg6Gai1ATiv64cQxNHde/ksxcGZJwoqXNZdM16shlbds/I+U5K0r3RC7OyhNm8LrC9/mDri3MfPivJgwrjBuC2E0feEGeDNwEVGN1skVCIeLmjd+fsGa96lUo9W5FZwoszO5CObdEXRkhTUO1raH/VSzW37HvEM3Xpwquuu/wqMp80nAeDLLeRwSDE/EuDi8nFyomNjuMYVkKM4P7n4kEMsmslWO9FSnSp5Poq71zMd9zXOO1tn5rZXEDpy/4XkKR5XhKMl+Brhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756334607; c=relaxed/relaxed;
	bh=LKcxlPw0uQjBkw7eQMnE+gmOL2ekj9P4WG4v5yuEZSw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OhJic589RG/nKWrcAX9+/I19BH/jXYQ2PfDZKEGtZdG4mHymd9chBWYn6MVCLjdujppib3oYTEM+q4Kw7jmuclR5voeNnWou96C6GMTeWeYjd2hAF/7OPixPGEtp09nLuqKZpAG5DL/GZ5G13aImVLt6HI/dGK3QYpiSOKdIdPo3EiAeVqoL5mPJOf1RJ6AKhhCtx7QVkuJjDS8Q1VGDJA6fsirsFLBnaVG/8VwDTRklKib2JkfayDTYaJstpWIPOGOeP61y75+shLgQH9QByfxYFFq4b7s+e4+v+zKPXPp+kn86lrDdKsgF3MLwV9pbN/dtsgPSAkQHdgNmU0ga1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=nbHeXXrh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::104a; helo=mail-pj1-x104a.google.com; envelope-from=3coqvaaskcykfhpjwqjdysllttlqj.htrqnszc-jwtkxqnxyx.teqfgx.twl@flex--ackerleytng.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=nbHeXXrh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ackerleytng.bounces.google.com (client-ip=2607:f8b0:4864:20::104a; helo=mail-pj1-x104a.google.com; envelope-from=3coqvaaskcykfhpjwqjdysllttlqj.htrqnszc-jwtkxqnxyx.teqfgx.twl@flex--ackerleytng.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cC01V1qV8z2xQ1
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Aug 2025 08:43:25 +1000 (AEST)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-3235e45b815so350565a91.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 27 Aug 2025 15:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756334602; x=1756939402; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LKcxlPw0uQjBkw7eQMnE+gmOL2ekj9P4WG4v5yuEZSw=;
        b=nbHeXXrhZ6hFso+rA4K3WBRMHrP17f2xegqtsZHyjWmxOqnGaV1kmewcAZTnD0+xw0
         VpOzK/hduXdCgI4i4f5HjkKiN/rd7QK//wKyNZy3xyeY6cR7iZS9nU7O5uYBRsFJaBep
         xmCMoBfg7KzG1d37Ym+6Q6A8wk3f8XHs+v6v059OW8VXVDnxIxKjxQWlEv2GlZbawDNP
         UxikyPfjoS15BlwCRMBiCqSavvsup/gCXckOkQ02CHXQGOBprokYLisq2gnCcsNwEceF
         Ih8krm2YNN5zCVH1Qo0FoZ9pRDFdVN2Pe0bsfoi7KZc3yenEMhw7HEj9J4/MFMk/AWpu
         /54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756334602; x=1756939402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKcxlPw0uQjBkw7eQMnE+gmOL2ekj9P4WG4v5yuEZSw=;
        b=R7DUKwv8RfQCV3J+aBwjtEig9SkpGbWRsFVc7+RFLUzqsO6gCKcUlmn2EGp/xma57/
         YbcrgQx5E1XFzga16rxc5KWMgSmVHV6rmgybLoGDUixUT7floQUAUKKkcMWZggnNBOMU
         yPQKeWlm4OgKmJyH+XhoxyvP/Gi0nk+RkGrTJ/teJ1ImfL7Kn0xvp96A4E6Ag5eBSIrI
         bLtTp/VZ17+eemGZMU1CS1vcEjTa+mel0z4xb9fA2isTpiWtq8Ilk+C8iytYXpGwH8nl
         fEjoG0IFaq60UyC7vxv3HZy0VE6LvHLb990vNmOKWoJY3kBA7psXw3dZzGtSpdtsLtQP
         +ObA==
X-Forwarded-Encrypted: i=1; AJvYcCXUuAP5K7zDgTXQAxeb/SbHNWeU7ki5XSQtNaFU/v1rkXzMCL7fjWc6/9qNUcCf4NnCwgAv3IWS80hLKg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw4GTxY7dz4K7MyuCvlWqEfjIDz2PrXy4qcbrYwITS0tmj4Aye5
	vuUQOYyQIM84Uzk0R+YLGHPJ+APdgrTuzKFBAZgQJdTZTznfGCDladMh3kx2NnbFcZRtsE+aL/h
	q3sUf4wZ50prco4K1rTMKXmlIbA==
X-Google-Smtp-Source: AGHT+IGNhCki+zRNFnf7AupQOwuzR8TBEtFWXAfIyU7yRpBo61MiAC41fjzXQhOiSXx1TrtlLAFGHZ8M3ImJd0zqNQ==
X-Received: from pjl11.prod.google.com ([2002:a17:90b:2f8b:b0:325:7fbe:1c64])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:da8c:b0:327:7c8e:8725 with SMTP id 98e67ed59e1d1-3277c8eb5a6mr3670514a91.10.1756334602319;
 Wed, 27 Aug 2025 15:43:22 -0700 (PDT)
Date: Wed, 27 Aug 2025 15:43:20 -0700
In-Reply-To: <20250827175247.83322-7-shivankg@amd.com>
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
Mime-Version: 1.0
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-7-shivankg@amd.com>
Message-ID: <diqztt1sbd2v.fsf@google.com>
Subject: Re: [PATCH kvm-next V11 4/7] KVM: guest_memfd: Use guest mem inodes
 instead of anonymous inodes
From: Ackerley Tng <ackerleytng@google.com>
To: Shivank Garg <shivankg@amd.com>, willy@infradead.org, akpm@linux-foundation.org, 
	david@redhat.com, pbonzini@redhat.com, shuah@kernel.org, seanjc@google.com, 
	vbabka@suse.cz
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com, 
	xiang@kernel.org, chao@kernel.org, jaegeuk@kernel.org, clm@fb.com, 
	josef@toxicpanda.com, kent.overstreet@linux.dev, zbestahu@gmail.com, 
	jefflexu@linux.alibaba.com, dhavale@google.com, lihongbo22@huawei.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	tabba@google.com, shivankg@amd.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, vannapurve@google.com, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, 
	kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, hch@infradead.org, 
	cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com, 
	roypat@amazon.co.uk, chao.p.peng@intel.com, amit@infradead.org, 
	ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com, 
	gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com, 
	yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Shivank Garg <shivankg@amd.com> writes:

> 
> [...snip...]
> 

I meant to send this to you before this version went out but you were
too quick!

Here's a new version, Fuad and I reviewed this again internally. The
changes are:

+ Sort linux/pseudo_fs.h after linux/pagemap.h (alphabetical)
+ Don't set MNT_NOEXEC on the mount, since SB_I_NOEXEC was already set
  on the superblock
+ Rename kvm_gmem_inode_make_secure_inode() to kvm_gmem_inode_create()
    + Emphasizes that there is a creation in this function
    + Remove "secure" from the function name to remove confusion that
      there may be a "non-secure" version
+ In kvm_gmem_inode_create_getfile()'s error path, return ERR_PTR(err)
  directly instead of having a goto


From ada9814b216eac129ed44dffd3acf76fce2cc08a Mon Sep 17 00:00:00 2001
From: Ackerley Tng <ackerleytng@google.com>
Date: Sun, 13 Jul 2025 17:43:35 +0000
Subject: [PATCH] KVM: guest_memfd: Use guest mem inodes instead of anonymous
 inodes

guest_memfd's inode represents memory the guest_memfd is
providing. guest_memfd's file represents a struct kvm's view of that
memory.

Using a custom inode allows customization of the inode teardown
process via callbacks. For example, ->evict_inode() allows
customization of the truncation process on file close, and
->destroy_inode() and ->free_inode() allow customization of the inode
freeing process.

Customizing the truncation process allows flexibility in management of
guest_memfd memory and customization of the inode freeing process
allows proper cleanup of memory metadata stored on the inode.

Memory metadata is more appropriately stored on the inode (as opposed
to the file), since the metadata is for the memory and is not unique
to a specific binding and struct kvm.

Co-developed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/uapi/linux/magic.h |   1 +
 virt/kvm/guest_memfd.c     | 126 ++++++++++++++++++++++++++++++-------
 virt/kvm/kvm_main.c        |   7 ++-
 virt/kvm/kvm_mm.h          |   9 +--
 4 files changed, 116 insertions(+), 27 deletions(-)

diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index bb575f3ab45e5..638ca21b7a909 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -103,5 +103,6 @@
 #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
 #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
 #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
+#define GUEST_MEMFD_MAGIC	0x474d454d	/* "GMEM" */

 #endif /* __LINUX_MAGIC_H__ */
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 08a6bc7d25b60..234e51fd69ff6 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1,12 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/anon_inodes.h>
 #include <linux/backing-dev.h>
 #include <linux/falloc.h>
+#include <linux/fs.h>
 #include <linux/kvm_host.h>
 #include <linux/pagemap.h>
-#include <linux/anon_inodes.h>
+#include <linux/pseudo_fs.h>

 #include "kvm_mm.h"

+static struct vfsmount *kvm_gmem_mnt;
+
 struct kvm_gmem {
 	struct kvm *kvm;
 	struct xarray bindings;
@@ -385,9 +389,44 @@ static struct file_operations kvm_gmem_fops = {
 	.fallocate	= kvm_gmem_fallocate,
 };

-void kvm_gmem_init(struct module *module)
+static int kvm_gmem_init_fs_context(struct fs_context *fc)
+{
+	if (!init_pseudo(fc, GUEST_MEMFD_MAGIC))
+		return -ENOMEM;
+
+	fc->s_iflags |= SB_I_NOEXEC;
+	fc->s_iflags |= SB_I_NODEV;
+
+	return 0;
+}
+
+static struct file_system_type kvm_gmem_fs = {
+	.name		 = "guest_memfd",
+	.init_fs_context = kvm_gmem_init_fs_context,
+	.kill_sb	 = kill_anon_super,
+};
+
+static int kvm_gmem_init_mount(void)
+{
+	kvm_gmem_mnt = kern_mount(&kvm_gmem_fs);
+
+	if (IS_ERR(kvm_gmem_mnt))
+		return PTR_ERR(kvm_gmem_mnt);
+
+	return 0;
+}
+
+int kvm_gmem_init(struct module *module)
 {
 	kvm_gmem_fops.owner = module;
+
+	return kvm_gmem_init_mount();
+}
+
+void kvm_gmem_exit(void)
+{
+	kern_unmount(kvm_gmem_mnt);
+	kvm_gmem_mnt = NULL;
 }

 static int kvm_gmem_migrate_folio(struct address_space *mapping,
@@ -463,11 +502,70 @@ bool __weak kvm_arch_supports_gmem_mmap(struct kvm *kvm)
 	return true;
 }

+static struct inode *kvm_gmem_inode_create(const char *name, loff_t size,
+					   u64 flags)
+{
+	struct inode *inode;
+
+	inode = anon_inode_make_secure_inode(kvm_gmem_mnt->mnt_sb, name, NULL);
+	if (IS_ERR(inode))
+		return inode;
+
+	inode->i_private = (void *)(unsigned long)flags;
+	inode->i_op = &kvm_gmem_iops;
+	inode->i_mapping->a_ops = &kvm_gmem_aops;
+	inode->i_mode |= S_IFREG;
+	inode->i_size = size;
+	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
+	mapping_set_inaccessible(inode->i_mapping);
+	/* Unmovable mappings are supposed to be marked unevictable as well. */
+	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
+
+	return inode;
+}
+
+static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
+						  u64 flags)
+{
+	static const char *name = "[kvm-gmem]";
+	struct inode *inode;
+	struct file *file;
+	int err;
+
+	err = -ENOENT;
+	/* __fput() will take care of fops_put(). */
+	if (!fops_get(&kvm_gmem_fops))
+		goto err;
+
+	inode = kvm_gmem_inode_create(name, size, flags);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		goto err_fops_put;
+	}
+
+	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR,
+				 &kvm_gmem_fops);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_put_inode;
+	}
+
+	file->f_flags |= O_LARGEFILE;
+	file->private_data = priv;
+
+	return file;
+
+err_put_inode:
+	iput(inode);
+err_fops_put:
+	fops_put(&kvm_gmem_fops);
+err:
+	return ERR_PTR(err);
+}
+
 static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 {
-	const char *anon_name = "[kvm-gmem]";
 	struct kvm_gmem *gmem;
-	struct inode *inode;
 	struct file *file;
 	int fd, err;

@@ -481,32 +579,16 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 		goto err_fd;
 	}

-	file = anon_inode_create_getfile(anon_name, &kvm_gmem_fops, gmem,
-					 O_RDWR, NULL);
+	file = kvm_gmem_inode_create_getfile(gmem, size, flags);
 	if (IS_ERR(file)) {
 		err = PTR_ERR(file);
 		goto err_gmem;
 	}

-	file->f_flags |= O_LARGEFILE;
-
-	inode = file->f_inode;
-	WARN_ON(file->f_mapping != inode->i_mapping);
-
-	inode->i_private = (void *)(unsigned long)flags;
-	inode->i_op = &kvm_gmem_iops;
-	inode->i_mapping->a_ops = &kvm_gmem_aops;
-	inode->i_mode |= S_IFREG;
-	inode->i_size = size;
-	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
-	mapping_set_inaccessible(inode->i_mapping);
-	/* Unmovable mappings are supposed to be marked unevictable as well. */
-	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
-
 	kvm_get_kvm(kvm);
 	gmem->kvm = kvm;
 	xa_init(&gmem->bindings);
-	list_add(&gmem->entry, &inode->i_mapping->i_private_list);
+	list_add(&gmem->entry, &file_inode(file)->i_mapping->i_private_list);

 	fd_install(fd, file);
 	return fd;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 18f29ef935437..301d48d6e00d0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6489,7 +6489,9 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	if (WARN_ON_ONCE(r))
 		goto err_vfio;

-	kvm_gmem_init(module);
+	r = kvm_gmem_init(module);
+	if (r)
+		goto err_gmem;

 	r = kvm_init_virtualization();
 	if (r)
@@ -6510,6 +6512,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 err_register:
 	kvm_uninit_virtualization();
 err_virt:
+	kvm_gmem_exit();
+err_gmem:
 	kvm_vfio_ops_exit();
 err_vfio:
 	kvm_async_pf_deinit();
@@ -6541,6 +6545,7 @@ void kvm_exit(void)
 	for_each_possible_cpu(cpu)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
 	kmem_cache_destroy(kvm_vcpu_cache);
+	kvm_gmem_exit();
 	kvm_vfio_ops_exit();
 	kvm_async_pf_deinit();
 	kvm_irqfd_exit();
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 31defb08ccbab..9fcc5d5b7f8d0 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -68,17 +68,18 @@ static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
 #endif /* HAVE_KVM_PFNCACHE */

 #ifdef CONFIG_KVM_GUEST_MEMFD
-void kvm_gmem_init(struct module *module);
+int kvm_gmem_init(struct module *module);
+void kvm_gmem_exit(void);
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 		  unsigned int fd, loff_t offset);
 void kvm_gmem_unbind(struct kvm_memory_slot *slot);
 #else
-static inline void kvm_gmem_init(struct module *module)
+static inline int kvm_gmem_init(struct module *module)
 {
-
+	return 0;
 }
-
+static inline void kvm_gmem_exit(void) {};
 static inline int kvm_gmem_bind(struct kvm *kvm,
 					 struct kvm_memory_slot *slot,
 					 unsigned int fd, loff_t offset)
--
2.51.0.268.g9569e192d0-goog

