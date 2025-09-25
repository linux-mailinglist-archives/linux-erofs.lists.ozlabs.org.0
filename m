Return-Path: <linux-erofs+bounces-1103-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70185B9FE91
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Sep 2025 16:17:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXbPv0dLPz2yqR;
	Fri, 26 Sep 2025 00:17:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::549"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758809827;
	cv=none; b=WZlZjM9biF1ujqDDVxu2PFo/WSJmKCko8iCPBeuG9JkPSRsncr78DslqgUhCQdajP+pDO4nSwf+tfWnN4PVoi7shWIuMqP3ZW0AlSRXO4xzGXF4UdVj9eQX1AxKfE/RGIEgJ1uIQLoK+QbeipatpOo6lMNNiZokj6txjljtsI9pGEAelJ/4Adlh8TAZ5+QHZQgUGDI6uhaWp9QPnLDYnqVqfBM7nnDVulPzv2bzcNGEAlQX3oYfzwuojeleLy0cWsDYxx+29uUj6a2F+ARcxTs1lPKN0PnOp41XNDqs/3TBLwb2uSGauLm5Tt3yl5nz7FCcKz3eNCcdzoiw1nT8vVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758809827; c=relaxed/relaxed;
	bh=q01z2q70uBCSgJYAVR+vis46yH2U6fCb9IpR1jV5kvA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IjOsMplR89Tvr1HehuzoDSU84aLTKEKd1AHeB6O3jDZnJEAXgUy21ydNkROB3G6XCmJE4X0WgnOY/38lQO+xbgTuRq1spkkkSkxvYwKiEQIaRo6j4agFb9+iw4yJcdsqowT7xhG5LD0EL6J51LYtI9LQ5sjHm7Fc0Co0YE+K73hlY2XO3dbpZdNA6VYfIOme895rhtqMc5+PGrhEzNrcG7HjLcp8RBZsHNGjzqIzr7t4PUgDnyDnJUvp1cKT2pSNIfIdFIEw4Wky30TymSXQk7n7OHz7LC/DDrCkGkAubZgx3BQSnZAV0wA++MAPcupPXlvK/qHZpMGb9PgEZxmavQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=XYED1jcD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com; envelope-from=33k7vaaykcx8n95ie7bjjbg9.7jhgdips-9mjangdnon.jug56n.jmb@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=XYED1jcD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com; envelope-from=33k7vaaykcx8n95ie7bjjbg9.7jhgdips-9mjangdnon.jug56n.jmb@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cXbPt1rr4z2yqP
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Sep 2025 00:17:05 +1000 (AEST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-b5576590fd1so682430a12.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 07:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758809823; x=1759414623; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q01z2q70uBCSgJYAVR+vis46yH2U6fCb9IpR1jV5kvA=;
        b=XYED1jcDQi34HwPQZXbpKost+61VRuFo8AmLhR/4U+FApz+lMy3bkO0iiUGIfTFusL
         ZYQkevLhRgJwJ6Zy25fPGYNzWL1Yac8Ih+LPhwA99LI2aTUtAPn/LLFuGMcfQHF1YzSf
         N9bme52RhDNOkn44lJF5SmF+ObiaO+VsjkbGy1wrA33UjZL76JthJ0R5OyRqsjKK1LZI
         IDs3pdNLS8wGHB+HM2hsvfO6HzQ0h8uAqtnk0+bV8h69Arqt3LWRRRtDf53bdWm1ZFCY
         MP79MtkxtYCYGmQ2F9xPBp5Xw+82m3MbSTrk21ctbEP/PvBw9haRws5NWpm8riV2bcBn
         KU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758809823; x=1759414623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q01z2q70uBCSgJYAVR+vis46yH2U6fCb9IpR1jV5kvA=;
        b=um39YANCiMzoIgo24htGET1TAajUG1rmWGHfa96jH4xHKTaNOb5I06NwqQjMkFGEFn
         qU5PdLSBoVsuFOa1rtw3WcmDfRQ0Cw9rd5k3u+vYSa4Au6kEffgrkLwpR0j/u717vJan
         PzuTJxITc6BN7OAiAQOZ0HtEVkGEtJL38DGdL2dqBmWR37zkNO1/YlnIjDBv9Snl5gL8
         mRvZb5qbNcDywhte/ZBAt509OYKl9mN+P+u4vP4A3QfTRMha3vdfD9TBPzmAUGMXIhmw
         LN1vQjp3WovIfA3XCzxg6JXgSzh34MTdDKtMhnRTW4vTozZ1oNoLH4/sVwyczsvgQCDN
         SgLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbqK+XwL4ISvn6I8/bnJLYjqmtdpZB0DSgRrroD91e8wu5R6CIb9j0kCYMX/0WPULy5jV4yqFS5arpag==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyBeaemymSmpRTgetA5MwMAGS85U0ZcI/zKngAxnDVHCwALHigT
	oA92xPb0rxu29Dz8MS42r0XhSITCuwpEzuct0eSM0SwRKrHBn9QLLjRpTWqyP6dGCDKtBdzcDpv
	+ccRP+Q==
X-Google-Smtp-Source: AGHT+IGC7UvA+zy0Lzxdig1u574Z6HM9V6jNvtPYVpQ99Zo3hDJZ7LLoK6uH5QRKE/XipBEFnMeanJ3T9fg=
X-Received: from pjbon17.prod.google.com ([2002:a17:90b:1d11:b0:32e:e06a:4668])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3143:b0:32e:1ff5:5af4
 with SMTP id 98e67ed59e1d1-3342a2fe9ddmr3876418a91.35.1758809822200; Thu, 25
 Sep 2025 07:17:02 -0700 (PDT)
Date: Thu, 25 Sep 2025 07:17:00 -0700
In-Reply-To: <aNVMIRels8iCldOj@google.com>
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
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-8-shivankg@amd.com>
 <aNVMIRels8iCldOj@google.com>
Message-ID: <aNVO3Lr-_U5Bmvem@google.com>
Subject: Re: [PATCH kvm-next V11 5/7] KVM: guest_memfd: Add slab-allocated
 inode cache
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
> > Add dedicated inode structure (kvm_gmem_inode_info) and slab-allocated
> > inode cache for guest memory backing, similar to how shmem handles inodes.
> > 
> > This adds the necessary allocation/destruction functions and prepares
> > for upcoming guest_memfd NUMA policy support changes.
> > 
> > Signed-off-by: Shivank Garg <shivankg@amd.com>
> > ---
> >  virt/kvm/guest_memfd.c | 70 ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 68 insertions(+), 2 deletions(-)
> > 
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 6c66a0974055..356947d36a47 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -17,6 +17,15 @@ struct kvm_gmem {
> >  	struct list_head entry;
> >  };
> >  
> > +struct kvm_gmem_inode_info {
> 
> What about naming this simply gmem_inode?

Heh, after looking through other filesystems, they're fairly even on appending
_info or not.  My vote is definitely for gmem_inode.

Before we accumulate more inode usage, e.g. for in-place conversion (which is
actually why I started looking at this code), I think we should also settle on
naming for gmem_file and gmem_inode variables.

As below, "struct kvm_gmem *gmem" gets quite confusing once inodes are in the
picture, especially since that structure isn't _the_ gmem instance, rather it's
a VM's view of that gmem instance.  And on the other side, "info" for the inode
is a bit imprecise, e.g. doesn't immediately make me think of inodes.

A few ideas:

 (a)
   struct gmem_inode *gmem;
   struct gmem_file *f;

 (b)
   struct gmem_inode *gi;
   struct gmem_file *f;

 (c)
   struct gmem_inode *gi;
   struct gmem_file *gf;

 (d)
   struct gmem_inode *gmem_i;
   struct gmem_file *gmem_f;


I think my would be for (a) or (b).  Option (c) seems like it would be hard to
visually differentiate between "gi" and "gf", and gmem_{i,f} are a bit verbose
IMO.

> > +	struct inode vfs_inode;
> > +};
> > +
> > +static inline struct kvm_gmem_inode_info *KVM_GMEM_I(struct inode *inode)
> 
> And then GMEM_I()?
> 
> And then (in a later follow-up if we target this for 6.18, or as a prep patch if
> we push this out to 6.19), rename kvm_gmem to gmem_file?
> 
> That would make guest_memfd look a bit more like other filesystems, and I don't
> see a need to preface the local structures and helpers with "kvm_", e.g. GMEM_I()
> is analogous to x86's to_vmx() and to_svm().
> 
> As for renaming kvm_gmem => gmem_file, I wandered back into this code via Ackerley's
> in-place conversion series, and it took me a good long while to remember the roles
> of files vs. inodes in gmem.  That's probably a sign that the code needs clarification
> given that I wrote the original code.  :-)
> 
> Leveraging an old discussion[*], my thought is to get to this:
> 
> /*
>  * A guest_memfd instance can be associated multiple VMs, each with its own
>  * "view" of the underlying physical memory.
>  *
>  * The gmem's inode is effectively the raw underlying physical storage, and is
>  * used to track properties of the physical memory, while each gmem file is
>  * effectively a single VM's view of that storage, and is used to track assets
>  * specific to its associated VM, e.g. memslots=>gmem bindings.
>  */
> struct gmem_file {
> 	struct kvm *kvm;
> 	struct xarray bindings;
> 	struct list_head entry;
> };
> 
> struct gmem_inode {
> 	struct shared_policy policy;
> 	struct inode vfs_inode;
> };
> 
> [*] https://lore.kernel.org/all/ZLGiEfJZTyl7M8mS@google.com

