Return-Path: <linux-erofs+bounces-1108-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445B4BA1E98
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Sep 2025 01:03:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXq5b5FQjz30BW;
	Fri, 26 Sep 2025 09:03:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::104a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758841427;
	cv=none; b=FaNoCqEGT1UFosuRnwF5xEOUzFTzo2UkOSa0Bw0kUuGYa38EG0qOMLjkbsBA+37iCYSCOoulUx/61m89fmpeQivHRhvAbbUCl65JLHhifSJLNpA4YtXB2cgRttj7cN41kr+3sq6qDLpcF1iSmDK9R4NUeuTklmH1hDgYBW5wLAaymsRYV2OBCy3GsRiyFfq3iuHNTPZ3raG9W5kE2CrnUcWpNjYwgXFFdk6ZhzYgKaIY/O+0BR5TxnT48wPNyXUbtwJb2eTb6y8YcgHs4MxFxj97R6Gb0orG1VdzBJPBl1dOXF9iXiMvcGAR8rmDPCCMGJH7Fl7KrKg6LQl3e64mkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758841427; c=relaxed/relaxed;
	bh=XtCsq70qhQXvjo5i7WnTkFuUeYKslZCOA6r0Ck9tpm8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MSTqbUxeq4ciWrWrLeA/zevnQu1lRM9liez4eBychuRB6CPX2bnI4//sUsnbVF21lCQjN3MdTmxjEXfiZYY8tDFo6axUhqqfM0kO/l5547I7iHxgyXhlimUk5/P1McQpaxRnQB6pA2RyoxKeTA3qVETTM2P8Hoa0LFyJzjnZaQjXViBiHLikMlU2zA0KUCQnCqM8OcJGCmEYvI9rpFGLflxKiX5xpxCh1l/b/f7q9HmFcsyvBvarKCUTlhdADbxBembFrDle/lp2qMq6FhhYSkPqwKPbVGGD9KC+jMcgWwu+1nBDnzg+PaLQ0hv6uo7FIqBQRcfbLk+CYHYRFZ8Zbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=JGx4NN0P; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::104a; helo=mail-pj1-x104a.google.com; envelope-from=3t8rvaaykc4g4qmzvos00sxq.o0yxuz69-q30r4xu454.0bxmn4.03s@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=JGx4NN0P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::104a; helo=mail-pj1-x104a.google.com; envelope-from=3t8rvaaykc4g4qmzvos00sxq.o0yxuz69-q30r4xu454.0bxmn4.03s@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cXq5Z1y5wz307q
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Sep 2025 09:03:45 +1000 (AEST)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so1338678a91.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 16:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758841424; x=1759446224; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XtCsq70qhQXvjo5i7WnTkFuUeYKslZCOA6r0Ck9tpm8=;
        b=JGx4NN0PMGAmwAv5p5DdA/hNV0DaDFZ/+3nCeYvaEipvv2VCQqW3w0DjEg9bNXsbAm
         fxroi/ywSGpQqNSSm3GOAnqYCM4DTR3yulma1msdiVQv9B/zeOSYcijivzCz1t0rjXTa
         Mh63yAAZWblRp+D/N0mHwPjC2yxLPs7LDq7rEPqsbmhFJn4EyXbmuI/jlJ8Z3cuWAfb7
         ix/eWNj0oRWJ+zsIeNmEAAv/KdLN7K1S/tfyHpXFXkCFoXrUQqTvssTFHaqbtHOwSatk
         wQsyXHizextDP/BY5/4a+tmYNw1YEC0KjCSLof7uOLHj9xjDQwphk3kZV8R0rmiNsGY+
         nepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758841424; x=1759446224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtCsq70qhQXvjo5i7WnTkFuUeYKslZCOA6r0Ck9tpm8=;
        b=YU9qSunHqKjeSvjnoYfSIwlvrDef0cvv3i6Y9pHDUA93h+8GTiNVWagnH3kMD7QUi5
         kDX+Y88m+HHz0TLiVah/04pK7b7sO3sLtpVcl7v02TdmzMt4olC/IqrK15W5w00WsIHm
         gahwBx1pR0rWlF2oq4ZYIBhxkepNBc6IE0hHDBOXILlBxLiQ3H+NJDUQgrtEu+QbniVm
         d/nIgcvr+d3tGUvte1792+Si43VTEbhgius3d8OtK3mv5Gaqwv6FqN8C6xC0NNWxGXp0
         Uk98u+aZS9zRRlNlOoU4d/sqSLP3MCI39pPidrhfx00CV6E+vmlWzdxPRG3wflpdEvVe
         ePPg==
X-Forwarded-Encrypted: i=1; AJvYcCUlvw7qoNdn3uHfpGWbvaEi04Hp2GOyEFHIdI/7dbgQEic4jkgL+RuVfgQTzpk+rVUxlTVf/OlMnpySRg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz6kPwbWNgx416Py1DNYpRYkqAkBVy5x7UUlpq/YLEyk6hZLbiq
	9LVsM1ML5QpzVKFo5Oa42vHcbDZQXiM7bV9vvphvj6gMZQHz0ElVlvxmDqzdRIN/E453kZbfZQm
	/a5rDiw==
X-Google-Smtp-Source: AGHT+IFCIuxfWzAAq0mG13fuYXVsG7N7KK6Fo0/VQdrpMqaeQ2l1EixZPHW4Wo1ErVxR9DWPn0iSBzBRvc0=
X-Received: from pjbqo8.prod.google.com ([2002:a17:90b:3dc8:b0:330:6d2f:1b62])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b4f:b0:330:852e:2bcc
 with SMTP id 98e67ed59e1d1-3342a2ca0e6mr5749959a91.21.1758841423443; Thu, 25
 Sep 2025 16:03:43 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:03:41 -0700
In-Reply-To: <aNW1l-Wdk6wrigM8@google.com>
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
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-10-shivankg@amd.com>
 <aNW1l-Wdk6wrigM8@google.com>
Message-ID: <aNXKTUnxHQyds4sh@google.com>
Subject: Re: [PATCH kvm-next V11 7/7] KVM: guest_memfd: selftests: Add tests
 for mmap and NUMA policy support
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

On Thu, Sep 25, 2025, Sean Christopherson wrote:
> On Wed, Aug 27, 2025, Shivank Garg wrote:
> > Add tests for NUMA memory policy binding and NUMA aware allocation in
> > guest_memfd. This extends the existing selftests by adding proper
> > validation for:
> > - KVM GMEM set_policy and get_policy() vm_ops functionality using
> >   mbind() and get_mempolicy()
> > - NUMA policy application before and after memory allocation
> > 
> > These tests help ensure NUMA support for guest_memfd works correctly.
> > 
> > Signed-off-by: Shivank Garg <shivankg@amd.com>
> > ---
> >  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
> >  .../testing/selftests/kvm/guest_memfd_test.c  | 121 ++++++++++++++++++
> >  2 files changed, 122 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> > index 90f03f00cb04..c46cef2a7cd7 100644
> > --- a/tools/testing/selftests/kvm/Makefile.kvm
> > +++ b/tools/testing/selftests/kvm/Makefile.kvm
> > @@ -275,6 +275,7 @@ pgste-option = $(call try-run, echo 'int main(void) { return 0; }' | \
> >  	$(CC) -Werror -Wl$(comma)--s390-pgste -x c - -o "$$TMP",-Wl$(comma)--s390-pgste)
> >  
> >  LDLIBS += -ldl
> > +LDLIBS += -lnuma
> 
> Hrm, this is going to be very annoying.  I don't have libnuma-dev installed on
> any of my <too many> systems, and I doubt I'm alone.  Installing the package is
> trivial, but I'm a little wary of foisting that requirement on all KVM developers
> and build bots.
> 
> I'd be especially curious what ARM and RISC-V think, as NUMA is likely a bit less
> prevelant there.

Ugh, and it doesn't play nice with static linking.  I haven't tried running on a
NUMA system yet, so maybe it's benign?

/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/14/../../../x86_64-linux-gnu/libnuma.a(affinity.o): in function `affinity_ip':
(.text+0x629): warning: Using 'getaddrinfo' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking

