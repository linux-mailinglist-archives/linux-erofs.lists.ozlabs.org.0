Return-Path: <linux-erofs+bounces-2211-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD4NKqsnc2kAswAAu9opvQ
	(envelope-from <linux-erofs+bounces-2211-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jan 2026 08:47:55 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F0971F92
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jan 2026 08:47:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dy95N1RHgz2xJ5;
	Fri, 23 Jan 2026 18:47:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769154472;
	cv=none; b=CJE1NAEHyqTaIxkNzMgFzGajLdR0eYpzQ/d1PEaMXKJf2GxFYNdwY8qGz2nVMtTa7eBe1i6QRZ3LOq6rg5WfVBRoOVycyvCOo9Sx1K462T8DSNmqR+RL4gnN5h02nKnCcpBx/T0pqLKKUlSgxfrD1ZZqIc5xCuunq0EDfcck1reWFmbrc+zwDyS7nhU61d8uJQZkW1+k84MFOOnzRvQ4SYgaSAzq3kXHWgBDA95eDaYiDUlcq4qbd/qyg4fS8IhQwgpmz63/03ObwZFqblGzO6DVKr4d0k2Qpyxt/Oq7hFS4P2ONHtDBgvZUzgCf2NmkDVIKF0jmKxa1VAR6z1ueow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769154472; c=relaxed/relaxed;
	bh=d7Cved2U0cx1Ah0GRYbOwiLnpALcJilpWIO4L1x9IxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cer0ejgmpnVWFJ9qZpS+ZjB3rsfo04IELd4z8y3qr7S0FNiKE3GayHOXo/HD7GwhAZHhejQuU4uScmtaikbKiIQQCvH5lpPF1WSj+78eWGoRsvBuLp2slZCpQY4HRWE0XRQJVO+Hd2nBLj0Qx4ONvhIL//Z9Jj1mTRl/Y7/VH3xxHBBKrmFpa2496+9kUUK+JcauRPKbNoshP3A8i2Lybeyo6+xIGBKWt1ji1CD63xiQbZqnemxFNdJ1ectufMW+BrWozQW5Zt5An1SMbrNrVocjxT6j+sBdQ82qy+CrKKKMgdc7MOvxdsBB1FCI15BQ81syCiZdHcQXJ311r2AWzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Dhz6ArAn; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Dhz6ArAn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dy95M3Yhcz2x9M
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 18:47:51 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8F53D443C6;
	Fri, 23 Jan 2026 07:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6FAC2BC86;
	Fri, 23 Jan 2026 07:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769154469;
	bh=qZcCh8YaN75BaHxJI3n8DUClBttDVVefL2TarE8x2cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dhz6ArAnF4mrMgD2V9gaW0IOdAyt0UWHdcwmUQgrPBIWvnoaDzJtzmzMJxVck5gv+
	 zEZgJOeFD/IJQzx2Up99SCKmemnDSbXrWZlm1SAK7ny61M8KuplDc84jbfdlgQwQR6
	 +8Rb9fJ2j1Dh4UnsHETHjtBawHKcytU2E3ai7JjVMGK0KGDMhhcMz8n/3MAGSNlsTJ
	 lel+3wVzQK3+jEYSZdvY/T5wo14jtYZ5i4jErLaZOvUngMzlLTTOeS1t4am1xi1tfP
	 GskVtQYN+cTM93xV5bjb1azN9mPAsYErt+ynoEzLMYagl5talCo4C2ogUWa2ojcK07
	 lGuDTmdB4UMCw==
Date: Thu, 22 Jan 2026 23:47:48 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Benjamin LaHaise <bcrl@kvack.org>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Zi Yan <ziy@nvidia.com>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-mm@kvack.org, ntfs3@lists.linux.dev, devel@lists.orangefs.org,
	linux-xfs@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 09/13] mm: update all remaining mmap_prepare users to
 use vma_flags_t
Message-ID: <20260123074748.GX5945@frogsfrogsfrogs>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <fb1f55323799f09fe6a36865b31550c9ec67c225.1769097829.git.lorenzo.stoakes@oracle.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb1f55323799f09fe6a36865b31550c9ec67c225.1769097829.git.lorenzo.stoakes@oracle.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2211-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:lorenzo.stoakes@oracle.com,m:akpm@linux-foundation.org,m:jarkko@kernel.org,m:dave.hansen@linux.intel.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:dan.j.williams@intel.com,m:vishal.l.verma@intel.com,m:dave.jiang@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:jani.nikula@linux.intel.com,m:joonas.lahtinen@linux.intel.com,m:rodrigo.vivi@intel.com,m:tursulin@ursulin.net,m:christian.koenig@amd.com,m:ray.huang@amd.com,m:matthew.auld@intel.com,m:matthew.brost@intel.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:bcrl@kvack.org,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:muchun.song@linux.dev,m:osalvador@suse.de,m:david@kern
 el.org,m:almaz.alexandrovich@paragon-software.com,m:hubcap@omnibond.com,m:martin@omnibond.com,m:tony.luck@intel.com,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:cem@kernel.org,m:dlemoal@kernel.org,m:naohiro.aota@wdc.com,m:jth@kernel.org,m:willy@infradead.org,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:ziy@nvidia.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:jannh@google.com,m:pfalcato@suse.de,m:dhowells@redhat.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux-sgx@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nvdimm@lists.linux.dev,m:linux-cxl@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:intel-gfx@lists.freedesktop.org,m:linux-fsdevel@vger.kernel.org,m:linux-aio@kvack.org,m:linux-ero
 fs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-mm@kvack.org,m:ntfs3@lists.linux.dev,m:devel@lists.orangefs.org,m:linux-xfs@vger.kernel.org,m:keyrings@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:jgg@nvidia.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[djwong@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[94];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.458];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: B4F0971F92
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 04:06:18PM +0000, Lorenzo Stoakes wrote:
> We will be shortly removing the vm_flags_t field from vm_area_desc so we
> need to update all mmap_prepare users to only use the dessc->vma_flags
> field.
> 
> This patch achieves that and makes all ancillary changes required to make
> this possible.
> 
> This lays the groundwork for future work to eliminate the use of vm_flags_t
> in vm_area_desc altogether and more broadly throughout the kernel.
> 
> While we're here, we take the opportunity to replace VM_REMAP_FLAGS with
> VMA_REMAP_FLAGS, the vma_flags_t equivalent.
> 
> No functional changes intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  drivers/char/mem.c       |  6 +++---
>  drivers/dax/device.c     | 10 +++++-----
>  fs/aio.c                 |  2 +-
>  fs/erofs/data.c          |  5 +++--
>  fs/ext4/file.c           |  4 ++--
>  fs/ntfs3/file.c          |  2 +-
>  fs/orangefs/file.c       |  4 ++--
>  fs/ramfs/file-nommu.c    |  2 +-
>  fs/resctrl/pseudo_lock.c |  2 +-
>  fs/romfs/mmap-nommu.c    |  2 +-
>  fs/xfs/xfs_file.c        |  4 ++--
>  fs/zonefs/file.c         |  3 ++-
>  include/linux/dax.h      |  8 ++++----
>  include/linux/mm.h       | 24 +++++++++++++++++++-----
>  kernel/relay.c           |  2 +-
>  mm/memory.c              | 17 ++++++++---------
>  16 files changed, 56 insertions(+), 41 deletions(-)
> 

<snip to xfs>

> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 7874cf745af3..1238ec018bc7 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1974,14 +1974,14 @@ xfs_file_mmap_prepare(
>  	 * We don't support synchronous mappings for non-DAX files and
>  	 * for DAX files if underneath dax_device is not synchronous.
>  	 */
> -	if (!daxdev_mapping_supported(desc->vm_flags, file_inode(file),
> +	if (!daxdev_mapping_supported(desc, file_inode(file),
>  				      target->bt_daxdev))
>  		return -EOPNOTSUPP;
>  
>  	file_accessed(file);
>  	desc->vm_ops = &xfs_file_vm_ops;
>  	if (IS_DAX(inode))
> -		desc->vm_flags |= VM_HUGEPAGE;
> +		vma_desc_set_flags(desc, VMA_HUGEPAGE_BIT);

Looks good to me,
Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  	return 0;
>  }
>  

