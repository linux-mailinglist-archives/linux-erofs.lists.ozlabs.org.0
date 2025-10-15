Return-Path: <linux-erofs+bounces-1183-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9CBBE0DAB
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Oct 2025 23:46:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cn4Qp0Krlz2xQ5;
	Thu, 16 Oct 2025 08:46:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760564769;
	cv=none; b=F/jidiLiDFu+/X9293Mz/c0KS16yaUGacgOmt4vmyEx7uAksub76KxTZq4Ow98ul++oqJ+oDLOpXqPeTPQTwPpQqEXDFZVr3uRZoKN1XEi8W9ER8kOLtAgf3Zm8kzatDZOL4s/gMIJML7JSIzxTONpn7v+iUhyJSE0Pm19ywuPxnHgK44RQTVGOgRryyp9hEMyBEdHahoSHj363Phbe2n+tB6xB+78mmYVLYgqsJrPYgG5ZoaTo0TPeMFDlfUsc16CglXSThYNABr+5tImLBm2ntKNsd3suKkb263BWGYbyGWJtf/D1ojuIE85qnwtlPo0DTaLMcwe2ISEa16ZwEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760564769; c=relaxed/relaxed;
	bh=L3FMg1FEv7ZUbFziIBjfrlMH5r4d6/IdcxKlJL9nOzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NicBUAnC3jXlWKVxrCi1oM56Ss03yrUk+0jgg/RrkGitNFOAe7nFbnyGCtr2+9Zb1BQfSYqktxWvvgKnUAmfcZTmC1S1EWjSrkI3iNg0pIHKgN49YDdwb4NgZgZ1sa1ZH4ASaCAG4ap11bB5nVdfPBzAu/hIvlamJvabFuC1u+/8Evz+D0Og1CifJ8ipoZvztEItVPt2SN/aNfBSR8Ey5LPwnJeDBkmJskMxiRZuJMb+anx6eIttvS/QzpnQPhhVT1OGXbySehXuJ95tiz/2KG+zLU/T2UvNcRBdeF9UqdpSt8P98aqRT6d9XbG34X7Tiq+EQ2LSpJ6BXC9fKgbAhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net; dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=YGEZBkBV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72a; helo=mail-qk1-x72a.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org) smtp.mailfrom=gourry.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=YGEZBkBV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gourry.net (client-ip=2607:f8b0:4864:20::72a; helo=mail-qk1-x72a.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cn4Qj1jVxz2xQ4
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Oct 2025 08:46:04 +1100 (AEDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-85a4ceb4c3dso6347185a.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 15 Oct 2025 14:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760564762; x=1761169562; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L3FMg1FEv7ZUbFziIBjfrlMH5r4d6/IdcxKlJL9nOzQ=;
        b=YGEZBkBV7O30KW/gYcsy0T+mk8919SgAuOTqD6myuki0JjB7k+aFIIe32CZ4lYkNnE
         hWUQLx3gnZu+qps7V+1QQdBiataKfHRTjAHEWcx2gqmtZ+H9GBGry508Ig2DqJDk+u5j
         fgkf28rjjHjOKP71xABshyUq3ei5B46JWeojuu87Q/7WePtGNxagiJw6i8y01hOhpdAh
         KgbJwYDNJt0lq1lnfhIAatC5DPJckpGXQxrQuMLQkpOlMtt2XCNvxw5RnFCq2HCLr5B+
         e6qfPHIWL0Xlb2s0zBLnGX1gaJkiljc9D1btlLVELzyi2i9PKV6gIP+RL0ZCq/yDuJQN
         31OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760564762; x=1761169562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3FMg1FEv7ZUbFziIBjfrlMH5r4d6/IdcxKlJL9nOzQ=;
        b=ESKe7kzDvo8zBnGBVDUU+uVDnf7mzAaFwf2Gk3Mt1hlBrmAqcdxtzN3WuLCFIe/621
         1Yr88Bre9H0j17DJbWmLJvb+8XHRXZ+o8nd2OCyu4278qiFUjtPWM6d0AWEKWiRC/6jk
         jLS1xhsdO3QtiUixd/h2knRzsTOhqH0U1gM1Sl8CqR1mYzLLan28IjZuin1x35JbUYFV
         +QfYEAebTQLY199ssUg62xtH16qNVHy8Ry4U+zTnFRcEOiciPs9ZJcyjc3J+1J/m1qRW
         OGADdcFzPkF8S07Wucz65Dcqn5Z8V88E5SM6rmhvG9KBTQ9LPpfwgb5In4xtZ8eoV/Dn
         pNhA==
X-Forwarded-Encrypted: i=1; AJvYcCVyqLSSXGFQNTb9NY1oXNWL409VdQP2QDM3mRvfDoiF9CWKsPpYeuaIzOxpa3D4BpNTIelqzqya5x+y5g==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YycyPhjFpLVFxD8EMYw/KULgRnpmn0xsRQpb9CuIw9kSbimzXkv
	NH2ubLBVplYJjSVYLTvEAZVepK2TSUrotkV2yEebypT2G7sqYi1lkpmhckdy5BDdZnk=
X-Gm-Gg: ASbGncvsrjS9IyVvaeyM+MflZLtD5T8umI0bRlD7nJCCtCC7YHxXqwYoItcRHuve28N
	txdkz0XPxq9PejQogyt10QecgkLVlaBliQNCAH046QVvqxeQKN7r4o8WvaJy5xoweddNn6IE4UE
	ScQ3vgSYP5Q42rCSPIqUu9hUzIYxttxXu92bxUrXJGTf24K5xV/LyIuhFw66p7TQyqjvOYcXE01
	KHKSyQJ1GubNOj1E6vz9Fx1clZZcsHDih2O5sLVQ2S9za+Cx2BXA1HVk5aknSdYGirYvQD5jQQn
	EnjvpOY8NGrfD6DzAKMBvH3fRQ8pmspsdXq607Rniz2OXfQUH/Cw9oIhqcfmtyMO/p/OHXTtEPW
	S/rMOG5A9cJCBT+t3rnR29CUfguiaYE3mK1Ker3KwJIrSPk1SSdZji4tn8oTLMe3OmJwBvFJVDH
	qROSOF0RMtDXczX1jfpcKbdAgEZVlwVMvVOdER8rJJO09vxKT7BufjUBFReLijRhM6IlsfWg==
X-Google-Smtp-Source: AGHT+IGFaJmIXEF9qOWREfnISohaPtcOawCiX32gOo0axLN0cRb3DCKNrFn66v9UE7KAPGfO0N4wTQ==
X-Received: by 2002:a05:620a:1a02:b0:88e:86a3:98f1 with SMTP id af79cd13be357-88e86a39b78mr380325385a.45.1760564761659;
        Wed, 15 Oct 2025 14:46:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88f37e50ebasm56360985a.31.2025.10.15.14.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:46:00 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:45:57 -0400
From: Gregory Price <gourry@gourry.net>
To: Sean Christopherson <seanjc@google.com>
Cc: Shivank Garg <shivankg@amd.com>, jgowans@amazon.com, mhocko@suse.com,
	jack@suse.cz, kvm@vger.kernel.org, david@redhat.com,
	linux-btrfs@vger.kernel.org, aik@amd.com, papaluri@amd.com,
	kalyazin@amazon.com, peterx@redhat.com, linux-mm@kvack.org,
	clm@fb.com, ddutile@redhat.com, linux-kselftest@vger.kernel.org,
	shdhiman@amd.com, gshan@redhat.com, ying.huang@linux.alibaba.com,
	shuah@kernel.org, roypat@amazon.co.uk, matthew.brost@intel.com,
	linux-coco@lists.linux.dev, zbestahu@gmail.com,
	lorenzo.stoakes@oracle.com, linux-bcachefs@vger.kernel.org,
	ira.weiny@intel.com, dhavale@google.com, jmorris@namei.org,
	willy@infradead.org, hch@infradead.org, chao.gao@intel.com,
	tabba@google.com, ziy@nvidia.com, rientjes@google.com,
	yuzhao@google.com, xiang@kernel.org, nikunj@amd.com,
	serge@hallyn.com, amit@infradead.org, thomas.lendacky@amd.com,
	ashish.kalra@amd.com, chao.p.peng@intel.com, yan.y.zhao@intel.com,
	byungchul@sk.com, michael.day@amd.com, Neeraj.Upadhyay@amd.com,
	michael.roth@amd.com, bfoster@redhat.com, bharata@amd.com,
	josef@toxicpanda.com, Liam.Howlett@oracle.com,
	ackerleytng@google.com, dsterba@suse.com, viro@zeniv.linux.org.uk,
	jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
	dan.j.williams@intel.com, surenb@google.com, vbabka@suse.cz,
	paul@paul-moore.com, joshua.hahnjy@gmail.com, apopple@nvidia.com,
	brauner@kernel.org, quic_eberman@quicinc.com, rakie.kim@sk.com,
	cgzones@googlemail.com, pvorel@suse.cz,
	linux-erofs@lists.ozlabs.org, kent.overstreet@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, pankaj.gupta@amd.com,
	linux-security-module@vger.kernel.org, lihongbo22@huawei.com,
	linux-fsdevel@vger.kernel.org, pbonzini@redhat.com,
	akpm@linux-foundation.org, vannapurve@google.com,
	suzuki.poulose@arm.com, rppt@kernel.org, jgg@nvidia.com
Subject: Re: [f2fs-dev] [PATCH kvm-next V11 6/7] KVM: guest_memfd: Enforce
 NUMA mempolicy using shared policy
Message-ID: <aPAWFQyFLK4EKWVK@gourry-fedora-PF4VCD3F>
References: <20250827175247.83322-2-shivankg@amd.com>
 <20250827175247.83322-9-shivankg@amd.com>
 <aNVQJqYLX17v-fsf@google.com>
 <aNbrO7A7fSjb4W84@google.com>
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
In-Reply-To: <aNbrO7A7fSjb4W84@google.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, Sep 26, 2025 at 12:36:27PM -0700, Sean Christopherson via Linux-f2fs-devel wrote:
> > 
> > static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> > 					     unsigned long addr, pgoff_t *pgoff)
> > {
> > 	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> > 
> > 	return __kvm_gmem_get_policy(GMEM_I(file_inode(vma->vm_file)), *pgoff);
> 
> Argh!!!!!  This breaks the selftest because do_get_mempolicy() very specifically
> falls back to the default_policy, NOT to the current task's policy.  That is
> *exactly* the type of subtle detail that needs to be commented, because there's
> no way some random KVM developer is going to know that returning NULL here is
> important with respect to get_mempolicy() ABI.
> 

Do_get_mempolicy was designed to be accessed by the syscall, not as an in-kernel ABI.

get_task_policy also returns the default policy if there's nothing
there, because that's what applies.

I have dangerous questions:

why is __kvm_gmem_get_policy using
	mpol_shared_policy_lookup()
instead of
	get_vma_policy()

get_vma_policy does this all for you

struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
                                 unsigned long addr, int order, pgoff_t *ilx)
{
        struct mempolicy *pol;

        pol = __get_vma_policy(vma, addr, ilx);
        if (!pol)
                pol = get_task_policy(current);
        if (pol->mode == MPOL_INTERLEAVE ||
            pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
                *ilx += vma->vm_pgoff >> order;
                *ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
        }
        return pol;
}

Of course you still have the same issue: get_task_policy will return the
default, because that's what applies.

do_get_mempolicy just seems like the completely incorrect interface to
be using here.

~Gregory

