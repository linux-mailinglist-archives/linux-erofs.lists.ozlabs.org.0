Return-Path: <linux-erofs+bounces-1184-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F99BE0F8B
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Oct 2025 00:48:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cn5q005vqz305M;
	Thu, 16 Oct 2025 09:48:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::44a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760568523;
	cv=none; b=VkvuubcthIJH9bny+lfbONyUvBKAG+MA/nXYzTPkIymJ+DPOdlKQu3b9ejr5o/VzIx7sAU+YEWrNNdkTmkD2Vy63dJs6KGXKWKVcbRDNtIhbzXXPM4eLEQ9Xnxb/dhAcbhPKgRsVPA1ZJ9QEQkBgkXI3l3+KtNmAhnhcuttl2qHjjCg7kQYGrIFdwLdCm3/Y+8LL/ebbDUfOAZflW5J3nk8MVKaM9e4ZeEMKXhuckZNiQKZ++K98bsEhTgQbxeaBccuU5pAAAmOEBnvenoOB3YIWjoxg6YIjsiic1iBp/UMn+rMA9R3hzGWKul6N6tRxjktAPMnG2/byjUqBe4CatA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760568523; c=relaxed/relaxed;
	bh=VfHhobHRKUrZuY035WUhQS9GUM0Uyoej5h99Za9ASAY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FH3IsMZd0MvsPmGlezg0xo7llssUi/S4Xo0ne+yKxKG9XPofFbXJg+xjSrBCNjlYSGIh+bmNgZsptWnDEIpJ6MeccNmf5QwZaxug82lKRloJGbaw9lxJO6M7QkB1CtHtIRmouTrgKJNXVPRhBxPU6alrEWzvbtngPhvm7aMUcG6tcrFHroKj9NHa7ikN6v0mOvE0qzfppzlRAc8dGcRW7tWjYlcLSeMQUfrW0M/XD7TAR17AVP9KqfGmLvmZxSjn0M5647jWENHVeDOP02MviHag5s+Jeb2U1GeDf4sI4lC8Tzukb6QpgsE4xADK8qhzURXTSGOiblyqaapKDAy+pQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=Rb+ssO6f; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3xytwaaykcyaoa6jf8ckkcha.8kihejqt-ankboheopo.kvh67o.knc@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=Rb+ssO6f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3xytwaaykcyaoa6jf8ckkcha.8kihejqt-ankboheopo.kvh67o.knc@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cn5py4gSdz2xQ2
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Oct 2025 09:48:41 +1100 (AEDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-7811a602576so213431b3a.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 15 Oct 2025 15:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760568520; x=1761173320; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VfHhobHRKUrZuY035WUhQS9GUM0Uyoej5h99Za9ASAY=;
        b=Rb+ssO6fKeBUPcCUCwI6hT+FlxfxgoDPQBUFH696yAIzsxTXAwlBjYMMqpSdPog1OP
         FHTdfKxGrm/L8BKnmda+BMUX9LZ8MMvSw8XE3omxlfmZqNkUvDnO2duo3N6JgRlfOBgN
         FmNyk95z+xJGhbS4C+0Ld8f22a7wWn7PFD2cF9k9EmXZ4FC4nbYKP60Dkgl6+ePthD5F
         7IL6COkHK4G65XdfFmOatj0vWdk+D4aJBb/xAYyLbe7S2EKGsXW/HsqV92fbkGl7gnk4
         bM4+W4dnhzhCJ7cUGFK/ZXKx7XcqoIeMeRtn6BPjJIH3u4wHaELYGCb8rWOHn/W/syOU
         DC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760568520; x=1761173320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfHhobHRKUrZuY035WUhQS9GUM0Uyoej5h99Za9ASAY=;
        b=LWg8eHR6QyMFQ9KsHSdm1ryti7C+ZPa/G3TJSZs9h0L2ylLhsA74pDVLXXMdtlCG3k
         U3Rfj9r/29XkbbCInZ9R4x5ZC9THfxEazZvjoqyZGD25yRk0NeC640VCjErDlL6W4D5W
         fVajwwDhGnHDd8viiZIfTqGW/lgwQ9iQoc1QOIRqoQ2qZUWUYXNZCKRO9v0zzyJpPMCC
         QKQdg4FTiwcMudwb7jJ+IwVvQ79xzMjomksH7yC3MM57zAuW5tFuRhx+rZqidJuJMSMS
         qeSZz8K+pSSx9cRA5JVpSeTwXoLB8g/DmSyLZPyZ5KiN5D7OzL2ymXgPMKQFAvV9sTYz
         YKVg==
X-Forwarded-Encrypted: i=1; AJvYcCVxANPM0r5caLXQ0nMJPboAHd8AFet6AKo5O2KUHneJ/ScltUefMNHVm5DsD72DOb8tmHy2QDQx5yNW0Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwPrWGf/aiPgon1z/4cCnHaxuIr3ac8uOOckpsrPDswvVkMUicl
	tVNJimmlkIDpr/hvh4Z7Y6yRFeMThJ7vHj5I9RBQQhuGMWy1MYprNrrkthqEUFZPrib2Kjy4YjH
	HWjuhgg==
X-Google-Smtp-Source: AGHT+IEyb34/gE6QWzF0uzhcKPL3N9PV8BEpaNWr9b3Rp3K51ypbe1jmOBzkgqmwgOny3WdOfUFKvL+VZBw=
X-Received: from pjz11.prod.google.com ([2002:a17:90b:56cb:b0:33b:a35b:861])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7351:b0:251:c33d:2783
 with SMTP id adf61e73a8af0-32da813ce42mr40108259637.23.1760568519460; Wed, 15
 Oct 2025 15:48:39 -0700 (PDT)
Date: Wed, 15 Oct 2025 15:48:38 -0700
In-Reply-To: <aPAWFQyFLK4EKWVK@gourry-fedora-PF4VCD3F>
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
 <aNVQJqYLX17v-fsf@google.com> <aNbrO7A7fSjb4W84@google.com> <aPAWFQyFLK4EKWVK@gourry-fedora-PF4VCD3F>
Message-ID: <aPAkxp67-R9aQ8oN@google.com>
Subject: Re: [f2fs-dev] [PATCH kvm-next V11 6/7] KVM: guest_memfd: Enforce
 NUMA mempolicy using shared policy
From: Sean Christopherson <seanjc@google.com>
To: Gregory Price <gourry@gourry.net>
Cc: Shivank Garg <shivankg@amd.com>, jgowans@amazon.com, mhocko@suse.com, jack@suse.cz, 
	kvm@vger.kernel.org, david@redhat.com, linux-btrfs@vger.kernel.org, 
	aik@amd.com, papaluri@amd.com, kalyazin@amazon.com, peterx@redhat.com, 
	linux-mm@kvack.org, clm@fb.com, ddutile@redhat.com, 
	linux-kselftest@vger.kernel.org, shdhiman@amd.com, gshan@redhat.com, 
	ying.huang@linux.alibaba.com, shuah@kernel.org, roypat@amazon.co.uk, 
	matthew.brost@intel.com, linux-coco@lists.linux.dev, zbestahu@gmail.com, 
	lorenzo.stoakes@oracle.com, linux-bcachefs@vger.kernel.org, 
	ira.weiny@intel.com, dhavale@google.com, jmorris@namei.org, 
	willy@infradead.org, hch@infradead.org, chao.gao@intel.com, tabba@google.com, 
	ziy@nvidia.com, rientjes@google.com, yuzhao@google.com, xiang@kernel.org, 
	nikunj@amd.com, serge@hallyn.com, amit@infradead.org, thomas.lendacky@amd.com, 
	ashish.kalra@amd.com, chao.p.peng@intel.com, yan.y.zhao@intel.com, 
	byungchul@sk.com, michael.day@amd.com, Neeraj.Upadhyay@amd.com, 
	michael.roth@amd.com, bfoster@redhat.com, bharata@amd.com, 
	josef@toxicpanda.com, Liam.Howlett@oracle.com, ackerleytng@google.com, 
	dsterba@suse.com, viro@zeniv.linux.org.uk, jefflexu@linux.alibaba.com, 
	jaegeuk@kernel.org, dan.j.williams@intel.com, surenb@google.com, 
	vbabka@suse.cz, paul@paul-moore.com, joshua.hahnjy@gmail.com, 
	apopple@nvidia.com, brauner@kernel.org, quic_eberman@quicinc.com, 
	rakie.kim@sk.com, cgzones@googlemail.com, pvorel@suse.cz, 
	linux-erofs@lists.ozlabs.org, kent.overstreet@linux.dev, 
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	pankaj.gupta@amd.com, linux-security-module@vger.kernel.org, 
	lihongbo22@huawei.com, linux-fsdevel@vger.kernel.org, pbonzini@redhat.com, 
	akpm@linux-foundation.org, vannapurve@google.com, suzuki.poulose@arm.com, 
	rppt@kernel.org, jgg@nvidia.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Oct 15, 2025, Gregory Price wrote:
> On Fri, Sep 26, 2025 at 12:36:27PM -0700, Sean Christopherson via Linux-f2fs-devel wrote:
> > > 
> > > static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> > > 					     unsigned long addr, pgoff_t *pgoff)
> > > {
> > > 	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> > > 
> > > 	return __kvm_gmem_get_policy(GMEM_I(file_inode(vma->vm_file)), *pgoff);
> > 
> > Argh!!!!!  This breaks the selftest because do_get_mempolicy() very specifically
> > falls back to the default_policy, NOT to the current task's policy.  That is
> > *exactly* the type of subtle detail that needs to be commented, because there's
> > no way some random KVM developer is going to know that returning NULL here is
> > important with respect to get_mempolicy() ABI.
> > 
> 
> Do_get_mempolicy was designed to be accessed by the syscall, not as an
> in-kernel ABI.

Ya, by "get_mempolicy() ABI" I meant the uABI for the get_mempolicy syscall.

> get_task_policy also returns the default policy if there's nothing
> there, because that's what applies.
> 
> I have dangerous questions:

Not dangerous at all, I find them very helpful!

> why is __kvm_gmem_get_policy using
> 	mpol_shared_policy_lookup()
> instead of
> 	get_vma_policy()

With the disclaimer that I haven't followed the gory details of this series super
closely, my understanding is...

Because the VMA is a means to an end, and we want the policy to persist even if
the VMA goes away.

With guest_memfd, KVM effectively inverts the standard MMU model.  Instead of mm/
being the primary MMU and KVM being a secondary MMU, guest_memfd is the primary
MMU and any VMAs are secondary (mostly; it's probably more like 1a and 1b).  This
allows KVM to map guest_memfd memory into a guest without a VMA, or with more
permissions than are granted to host userspace, e.g. guest_memfd memory could be
writable by the guest, but read-only for userspace.

But we still want to support things like mbind() so that userspace can ensure
guest_memfd allocations align with the vNUMA topology presented to the guest,
or are bound to the NUMA node where the VM will run.  We considered adding equivalent
file-based syscalls, e.g. fbind(), but IIRC the consensus was that doing so was
unnecessary (and potentially messy?) since we were planning on eventually adding
mmap() support to guest_memfd anyways.

> get_vma_policy does this all for you

I assume that doesn't work if the intent is for new VMAs to pick up the existing
policy from guest_memfd?  And more importantly, guest_memfd needs to hook
->set_policy so that changes through e.g. mbind() persist beyond the lifetime of
the VMA.

> struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
>                                  unsigned long addr, int order, pgoff_t *ilx)
> {
>         struct mempolicy *pol;
> 
>         pol = __get_vma_policy(vma, addr, ilx);
>         if (!pol)
>                 pol = get_task_policy(current);
>         if (pol->mode == MPOL_INTERLEAVE ||
>             pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
>                 *ilx += vma->vm_pgoff >> order;
>                 *ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
>         }
>         return pol;
> }
> 
> Of course you still have the same issue: get_task_policy will return the
> default, because that's what applies.
> 
> do_get_mempolicy just seems like the completely incorrect interface to
> be using here.

