Return-Path: <linux-erofs+bounces-1104-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DA8B9FF51
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Sep 2025 16:22:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXbXD15rjz2yqR;
	Fri, 26 Sep 2025 00:22:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::54a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758810156;
	cv=none; b=il6yf1WYVRqB5hkBQQGMNeFGYCl7XiC/ioo7b3DyKsD4gDoE0amdR0CIDGf64SZyhgRvoqzE6xqpf2Q0BaKwIekq3DEusSnYtjtwANODwOmz9G1MzkXK/4Vg97i6egwGM44vxU1aPv4tyyK3whxFWc5Nk8tfi0I0O8AEvKjW3rgaZbl4Q/V4ZX5iPMWe3nXfH5pKjoDW/T7FMGD+u8APgD5Q70p+yyfmPMW+pkj68IxBhCLtAqInFQUTIB7Ng/RWRFKb5HQ9g+fExidkwFtOCiJ338A/isgIs/IZwTluO27hRNUFb9aln030hbycdw7splJjSGtUeDGt6N7z532s4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758810156; c=relaxed/relaxed;
	bh=SblUb3K9vKSfuIkumtnWvH3DVTbw+wxBSl+ZySJr9Gg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WlU0Pihcz4Ffk58w1Fvf8jHGQtKwfHzRvjU8PezoqP2jZKeFAEuBhptmYxku/GM4Klhh2LC0faJWRhsM9w42PGIkhYuzWxoOIBKqLn4TNVetqixjxlOz8jPFdKyTJih0ew24L08Wgtd9ppmECza7/+cUAAZTDYigQvp8q0O1yno0uIKD+/JNAVkmpULLlIvYfLl7BEV4MLNIEATbXusrmhu7EoMvNKiq97BwUzYX+2QoE8VlNpxWwe2WGg5hAFiCwLuh03vTLNpM7UBxICdmY0RRlczAyKSQ/Pdyau8/1azuxew/pHdG/bVRAK8zphYgnth5NFWkveP7LLVxZXCEbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=AocWEc/g; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com; envelope-from=3kfdvaaykc2sbnjwslpxxpun.lxvurwdg-naxoburbcb.xiujkb.xap@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=AocWEc/g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com; envelope-from=3kfdvaaykc2sbnjwslpxxpun.lxvurwdg-naxoburbcb.xiujkb.xap@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cXbXC23N2z2yqP
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Sep 2025 00:22:34 +1000 (AEST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-b54a30515cfso1610146a12.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758810152; x=1759414952; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SblUb3K9vKSfuIkumtnWvH3DVTbw+wxBSl+ZySJr9Gg=;
        b=AocWEc/gKz0lG30eNrTTzg4NXR2VNBQIs9nqVQ6sAio9yFtrt1aVE5I/YA80nYhY15
         Y5fiJVeBiLyX1uf9Tu9t1vKvfTQw9yYTnDBL0e6KRXd9eZgOpq+Jil3m+3gDmLljS2l8
         NhEQC2P1yF9LcA8IGM4VUvEV0efPv1qXfOYKaLFoI9/0uUeX2qz1kHE7nj20lnMjphx/
         WUjhXzrwxOnMSiYjzzcK9BcdFvlRDAxCPQErsfykqxRK6phIgSmOTRCaEW3MacR7zqBV
         rX32RxgFbVwifv3j3XVQitKCD6r5xQJhyhJViSm3n81G34i+I8xUv/u5jx+T3X8PeJb7
         EUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758810152; x=1759414952;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SblUb3K9vKSfuIkumtnWvH3DVTbw+wxBSl+ZySJr9Gg=;
        b=QbQv/j/YRh//yydV420P2qemoIWYaKiWLfj8zbx90r2UOSGg3pxa/CGP8h5w8CQQaV
         yuP/f2cQ8YcIaoL0l7IaPZscuKBIRCNm6E/AP7Ryq7N1kfzkzq/1jMzwl1LWhkTduhnR
         601RRD4zWQZ0IZaBRcpvX0oUBNsxLqaC/hAzFXh56596zkU2U/vW87SbCfr685djl/Mf
         k/+1jDQaKy4z3oYROlqQx/euF7Bp/qC6NNhq9Y5CT2id9QP1ErJcUdPaSbEmQ7LDg6qC
         mcvnt45rMRzu+rd4qR/UUnXmz8TOLG3uyXfDK76gUidBwl+Svif4CNYF65SKbrmHLRQ4
         WxWA==
X-Forwarded-Encrypted: i=1; AJvYcCWhzf9Xh0UYwE2WRIFY5kLg7su3BZhqL1tdgE4/Jb2uNck6uFrrkr8e7UCCx8J2Ivr2fjvxsGtgh8sl2Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz50WbEQXxx3nRz/imNZOHBZRdzw3c+0lvXJ3RNZyTbSBASRL8O
	UuAcAazLTCLygZoQd0MeO4Kfak0PtfI93t1LxnmqPW2RAHlbqgA0yIaOSb73F60UWVHFbiPWdyy
	qE/xebg==
X-Google-Smtp-Source: AGHT+IH/f88NvvxTkAVG4DhhjQkTxFzTBsV5SbcgowW0+JrB9EElqsyS6+jWyWSmkD83IUsL47BQyHKSocQ=
X-Received: from pjbmj16.prod.google.com ([2002:a17:90b:3690:b0:32e:c154:c2f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5107:b0:32b:a311:d1ae
 with SMTP id 98e67ed59e1d1-334567a1c56mr2743555a91.10.1758810152121; Thu, 25
 Sep 2025 07:22:32 -0700 (PDT)
Date: Thu, 25 Sep 2025 07:22:30 -0700
In-Reply-To: <20250827175247.83322-9-shivankg@amd.com>
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
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-9-shivankg@amd.com>
Message-ID: <aNVQJqYLX17v-fsf@google.com>
Subject: Re: [PATCH kvm-next V11 6/7] KVM: guest_memfd: Enforce NUMA mempolicy
 using shared policy
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, david@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, vbabka@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, dsterba@suse.com, xiang@kernel.org, chao@kernel.org, 
	jaegeuk@kernel.org, clm@fb.com, josef@toxicpanda.com, 
	kent.overstreet@linux.dev, zbestahu@gmail.com, jefflexu@linux.alibaba.com, 
	dhavale@google.com, lihongbo22@huawei.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, tabba@google.com, 
	ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org, 
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
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Aug 27, 2025, Shivank Garg wrote:
> @@ -26,6 +28,9 @@ static inline struct kvm_gmem_inode_info *KVM_GMEM_I(struct inode *inode)
>  	return container_of(inode, struct kvm_gmem_inode_info, vfs_inode);
>  }
>  
> +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
> +						   pgoff_t index);
> +
>  /**
>   * folio_file_pfn - like folio_file_page, but return a pfn.
>   * @folio: The folio which contains this index.
> @@ -112,7 +117,25 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  {
>  	/* TODO: Support huge pages. */
> -	return filemap_grab_folio(inode->i_mapping, index);
> +	struct mempolicy *policy;
> +	struct folio *folio;
> +
> +	/*
> +	 * Fast-path: See if folio is already present in mapping to avoid
> +	 * policy_lookup.
> +	 */
> +	folio = __filemap_get_folio(inode->i_mapping, index,
> +				    FGP_LOCK | FGP_ACCESSED, 0);
> +	if (!IS_ERR(folio))
> +		return folio;
> +
> +	policy = kvm_gmem_get_pgoff_policy(KVM_GMEM_I(inode), index);
> +	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
> +					 FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
> +					 mapping_gfp_mask(inode->i_mapping), policy);
> +	mpol_cond_put(policy);
> +
> +	return folio;
>  }
>  
>  static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
> @@ -372,8 +395,45 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_NUMA
> +static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpol)
> +{
> +	struct inode *inode = file_inode(vma->vm_file);
> +
> +	return mpol_set_shared_policy(&KVM_GMEM_I(inode)->policy, vma, mpol);
> +}
> +
> +static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> +					     unsigned long addr, pgoff_t *pgoff)
> +{
> +	struct inode *inode = file_inode(vma->vm_file);
> +
> +	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> +	return mpol_shared_policy_lookup(&KVM_GMEM_I(inode)->policy, *pgoff);
> +}
> +
> +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
> +						   pgoff_t index)

I keep reading this is "page offset policy", as opposed to "policy given a page
offset".  Another oddity that is confusing is that this helper explicitly does
get_task_policy(current), while kvm_gmem_get_policy() lets the caller do that.
The end result is the same, but I think it would be helpful for gmem to be
internally consistent.

If we have kvm_gmem_get_policy() use this helper, then we can kill two birds with
one stone:

static struct mempolicy *__kvm_gmem_get_policy(struct gmem_inode *gi,
					       pgoff_t index)
{
	struct mempolicy *mpol;

	mpol = mpol_shared_policy_lookup(&gi->policy, index);
	return mpol ? mpol : get_task_policy(current);
}

static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
					     unsigned long addr, pgoff_t *pgoff)
{
	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);

	return __kvm_gmem_get_policy(GMEM_I(file_inode(vma->vm_file)), *pgoff);
}

