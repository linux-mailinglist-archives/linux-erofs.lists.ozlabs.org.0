Return-Path: <linux-erofs+bounces-1264-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08636BF238D
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Oct 2025 17:52:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cr0L32s5Cz3020;
	Tue, 21 Oct 2025 02:52:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1049"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760975531;
	cv=none; b=RYGOAjE9uZsW2l2YP+Popi4SYCmIhtxT/So8mmrcAL9GTMJobs4dC4zoCciXX1XIE1kXXBIoN2GBLqyD5lgSGtCtCQukOSzZZTUjwIVBxcmq4YEUw52nCVhDMIy3mhInQwB0uYyfx+n1fqZbcGkd3CgMzCJEnpLzP0RHGpVOcBURxcvWKRMxGPtdopgmAnjv/VN6AdcybT8/enqdrcHuPm2kLM0T2y/AQax4reYuN2z4G4wJuvvra1O5nEsFgyGcmxSakM/SusFsqB14WL0U2QnFqtqCnAXNuhuuavROMKg+1QmEcCkF8SfdWTBtscSAijzzosM4ZJkatHVw0cQN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760975531; c=relaxed/relaxed;
	bh=YUxEjev6w4f1umuBxGfAcuaZR32QUUEbuSMBs3oceNE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SdbcUw08hYUZ34OJgwZ++WqeV0vE9Zskz7Z1xQJxi+hePsEXM4m7yUbkabE0/61uQxzEjCp9pWFjxjk0dN/47WXnGh98oIWQEGQ4TGhENEyZcGLup2MZZnP/FrQ8SWnl175Oqd/aF44ETnQ93xZGwG59NT+b/eb6tYi+yG7sannXJONZIpjmPJ4jgZEavOxXDpXzFqi3QSywrFFp4RlC1A/Qiky5TYLJFdTyIFmiXtkxuzQFKCAX9ljtuuBzkEgLQsJJ8ucDEOxyBy3GK98CDX7YoO2yUb/YJldG+puXKioIFse6JG9/6QcdurMGfhBDuf3+yxTjHV/GVI11gaBtYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=CELqp/XI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1049; helo=mail-pj1-x1049.google.com; envelope-from=3plr2aaykc4mzlhuqjnvvnsl.jvtspu14-lyvmzspz0z.v6shiz.vyn@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=CELqp/XI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::1049; helo=mail-pj1-x1049.google.com; envelope-from=3plr2aaykc4mzlhuqjnvvnsl.jvtspu14-lyvmzspz0z.v6shiz.vyn@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cr0L16vbnz300M
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Oct 2025 02:52:09 +1100 (AEDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so3699750a91.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 20 Oct 2025 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760975527; x=1761580327; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YUxEjev6w4f1umuBxGfAcuaZR32QUUEbuSMBs3oceNE=;
        b=CELqp/XIFx0fvhl3VALL3Waxg0cfdPO87AaCPKMCrCqqxyOquqbE5HWNn33cLmVngA
         4//I8xVlyYDyQad8f9TODMsJ8tY1jfWiUJnw7F1GyFooqs14addBjswCi6Hzz3Wcewge
         KUtCGpBIHftqgjQsk12+A2yAYXYXDF68xICz51M3ThM02zi3QtxIeikypNmX73sl8o72
         ejr+5W3H9JJa6CD2HfaCJe/aW4W47yhgHqMBHlfXnDyVx3n2Jy5czlBos6LgyeyiPbGm
         YdQ6LhK+GgNFmlmzGPpI/J15bSU8d1F06CY3nnvVPsUepAhFH0qaMSxUU/m2QaOczmBc
         n00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760975527; x=1761580327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUxEjev6w4f1umuBxGfAcuaZR32QUUEbuSMBs3oceNE=;
        b=a43x1M0DSy1x0IQ6EvH/IoTySfQuxLiUrXqUkyKwg/+G01wNkfa1sVHjIDvvhua+Bl
         VogmqtfjssAS/VUejdviK24O5KO9PnbK+QaYoL3s0ph21r3j7sS9mhSyZXBZclGfUElu
         cY1XufaORuSNa5WWEixIVj6MRuM6hu3g+mutJVZ+4j1zoWRH/RTmocGfpSNf/B0gCPp5
         KpBAIVJVdvwqssGHJVwGbKhR1+ys9vTJcyrN2oigtXSo9GvzueOVY1uSYHeVzg8wE4OC
         EDxwUidnjIdpFJqIEVTct89qvOfsdd7eAtJNK+qH26mHRLVpSM3VCPkiwvzu7eq1HYu7
         52eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGSj8vfil8BvM1gseB/Gwh8JisnX432PMGRIRN7wvZgcEnILapz71WboX/buRgHND7u20/amOhe5l/TA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzIBvVOYZyqyCONOhkQSqzlAdOxotXKTmRkwmOnJvMop2+EeZND
	3Am7SaRD3ycg8RMkhIzzvcqkKQEIAQmR45Wz8ta6dkoll9W6yU4rtAiLe9QFPExg3p8YP9+gQqM
	PQOb98Q==
X-Google-Smtp-Source: AGHT+IHcZobfkAMYLqgP+952/xufHk4lZqraqyIEs0BsZFGgLzowAsqRVArAQbVQNZgQWXn7bmNPNT9qaaI=
X-Received: from pjbds19.prod.google.com ([2002:a17:90b:8d3:b0:33b:51fe:1a84])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d85:b0:330:4a1d:223c
 with SMTP id 98e67ed59e1d1-33bcf87f421mr15625676a91.15.1760975526813; Mon, 20
 Oct 2025 08:52:06 -0700 (PDT)
Date: Mon, 20 Oct 2025 08:52:05 -0700
In-Reply-To: <176055105546.1527431.3611256810380818215.b4-ty@google.com>
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
References: <20250827175247.83322-2-shivankg@amd.com> <176055105546.1527431.3611256810380818215.b4-ty@google.com>
Message-ID: <aPZapWWFGyqjA2e3@google.com>
Subject: Re: [PATCH kvm-next V11 0/7] Add NUMA mempolicy support for KVM guest-memfd
From: Sean Christopherson <seanjc@google.com>
To: willy@infradead.org, akpm@linux-foundation.org, david@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, vbabka@suse.cz, 
	Shivank Garg <shivankg@amd.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com, 
	xiang@kernel.org, chao@kernel.org, jaegeuk@kernel.org, clm@fb.com, 
	josef@toxicpanda.com, kent.overstreet@linux.dev, zbestahu@gmail.com, 
	jefflexu@linux.alibaba.com, dhavale@google.com, lihongbo22@huawei.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	tabba@google.com, ackerleytng@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, 
	vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, 
	michael.day@amd.com, shdhiman@amd.com, yan.y.zhao@intel.com, 
	Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com, 
	aik@amd.com, kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, 
	hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com, 
	rientjes@google.com, roypat@amazon.co.uk, chao.p.peng@intel.com, 
	amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com, 
	ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com, 
	pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com, 
	suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-coco@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Oct 15, 2025, Sean Christopherson wrote:
> On Wed, 27 Aug 2025 17:52:41 +0000, Shivank Garg wrote:
> > This series introduces NUMA-aware memory placement support for KVM guests
> > with guest_memfd memory backends. It builds upon Fuad Tabba's work (V17)
> > that enabled host-mapping for guest_memfd memory [1] and can be applied
> > directly applied on KVM tree [2] (branch kvm-next, base commit: a6ad5413,
> > Merge branch 'guest-memfd-mmap' into HEAD)
> > 
> > == Background ==
> > KVM's guest-memfd memory backend currently lacks support for NUMA policy
> > enforcement, causing guest memory allocations to be distributed across host
> > nodes  according to kernel's default behavior, irrespective of any policy
> > specified by the VMM. This limitation arises because conventional userspace
> > NUMA control mechanisms like mbind(2) don't work since the memory isn't
> > directly mapped to userspace when allocations occur.
> > Fuad's work [1] provides the necessary mmap capability, and this series
> > leverages it to enable mbind(2).
> > 
> > [...]
> 
> Applied the non-KVM change to kvm-x86 gmem.  We're still tweaking and iterating
> on the KVM changes, but I fully expect them to land in 6.19.
> 
> Holler if you object to taking these through the kvm tree.
> 
> [1/7] mm/filemap: Add NUMA mempolicy support to filemap_alloc_folio()
>       https://github.com/kvm-x86/linux/commit/601aa29f762f
> [2/7] mm/filemap: Extend __filemap_get_folio() to support NUMA memory policies
>       https://github.com/kvm-x86/linux/commit/2bb25703e5bd
> [3/7] mm/mempolicy: Export memory policy symbols
>       https://github.com/kvm-x86/linux/commit/e1b4cf7d6be3

FYI, I rebased these onto 6.18-rc2 to avoid a silly merge.  New hashes:

[1/3] mm/filemap: Add NUMA mempolicy support to filemap_alloc_folio()
      https://github.com/kvm-x86/linux/commit/7f3779a3ac3e
[2/3] mm/filemap: Extend __filemap_get_folio() to support NUMA memory policies
      https://github.com/kvm-x86/linux/commit/16a542e22339
[3/3] mm/mempolicy: Export memory policy symbols
      https://github.com/kvm-x86/linux/commit/f634f10809ec

