Return-Path: <linux-erofs+bounces-1193-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D99BE3DD9
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Oct 2025 16:17:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnVQp5mhcz2ywC;
	Fri, 17 Oct 2025 01:17:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f2a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760624258;
	cv=none; b=V5DO1Y+MtUTkyegz1I8CoahzSm0xKIgee19Nxo5umFowp6Z3OF62j2VO6alSVHNpIFujdrx3rF088t54/i39xBeNtepTI/HB8vEi4yEgTe17597DwTK9+fCKLUNYIAdHfdq9zlDt55iYWQ7TVRI2WpkrXHKUP/H/4/Af4/eqxg9koU5C+5+/JmcrBs4rT0oCn8ATTE6GjD8w691oIUpK3qTAK4hvgpzXvybX+kiNFSqhH65AY8MCHu8+q47Rus69BCe0VKx8O0QhAhMoM7nt1ZD9BR+NWmFexoX/kgkOvU0140R04U8zlRisSIyx5S/n/szU5yx30OyNcyX9ro7+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760624258; c=relaxed/relaxed;
	bh=vDx8+7T+MYrCmWnRteKVa1iC6/sCWZvHc99T+OB8RqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQn+8gxy2ECZpwPU7UGF1qgIXVSTvztNZHF2OTNOOfZyBqPuGIzSVD+ea3Qd+z7R4AMu4eOMLfovLQsAiArp8aLsRuCaIN7WP+PdUsDAP1wpaW2Lot1H+okyX3KCBjFTD9DoOCeH3lo4jLf43LCWX6Ca8b3U/7lIC2jeMbvXll2Vqg1vAGvtSF2bjEqed7tb6z29YPQcOddvLYbXZu1373eazLkUGmolk2bm5dya9oFbKofdVM7GcHNavmoVk02c6+F38WRynbZ/qq5+RwpTzRlIsFOTRjNVc17xCtlvwSdrAAqYn+3yu1xqlFo8oiCP5H2FOnRZP7HdY6FyZoFmPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net; dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vEqgK6Oe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2a; helo=mail-qv1-xf2a.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org) smtp.mailfrom=gourry.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vEqgK6Oe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gourry.net (client-ip=2607:f8b0:4864:20::f2a; helo=mail-qv1-xf2a.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnVQn25xfz2yQH
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Oct 2025 01:17:36 +1100 (AEDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-87c1a760df5so11184156d6.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 16 Oct 2025 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760624251; x=1761229051; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDx8+7T+MYrCmWnRteKVa1iC6/sCWZvHc99T+OB8RqU=;
        b=vEqgK6Oe25CXgpIuXd1B3LcNQLvJ8bnBGYyt4ekC6s8ktEXWfXCXBfZ0caJzqt39m9
         aGwtNNubXxNB1Z7Vn4UwTLcuKGPSknsF45LYXzfBAYJi2QwraUo7m6ifK025W/kuWu+d
         x0FFGIoS71a9Bfek++6TmUDVltL7ABSPzu+XJqelSGGfom+hlF7qX4xNWAUFzfCCb/I5
         MJlDAuU6upiREhGLpT3cXnDT/mlXeOK2gb7NCwaYQ/nGuwvsnwLfGepeGB7xewoU0s1v
         4/b6ol/rxuZNvrdddmqaFf5iZEUvmqbQu0pOXjg55pL2jAItIU7FO4PyJ759ISRwQ8lh
         CSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760624251; x=1761229051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDx8+7T+MYrCmWnRteKVa1iC6/sCWZvHc99T+OB8RqU=;
        b=QSfPhIB5SyHkXXXDGoKP9006p9g9scy80LoxSUQutZ5kqSuhziFIXMZRWRMj9xEslI
         z/X1xNptigOUl4q6bhFTnUArge+ktFRJ2VNBtRRt82S/6MVTFKa+3HytPyGthNPJLtdk
         XEBHcyC/aQzRPqVuNyoabrl487taSJWiq6QIdzxjOMAM5JpsJ11FwRRlLqkCE3rDYcs2
         S068QUANQnZ820na4yMfZKCbtrRMjyITwQQYmYKvz1lxYVfU/nXgMkF6n7/jM1TonsBn
         57qm5QrFGgOs1LchvJC1AwI82cIIunZRSB6pBd+se4ytvtq8izXtWCkuyZJAwIkX5jvc
         Lmew==
X-Forwarded-Encrypted: i=1; AJvYcCV6bZrFRJg2WvzncqC//ypfyV/moEIjd/9aEBmEtsjWFA7/I/IV2ddCgRtN20F+Un/vIGAJzWzIp20hVA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwLGMfeGyHTiQV8xskzN9cuSngPh3N/VaO8lvJSAlT1FkLswirS
	K316S/D9g0VgetStW9qgtwEugZ9l4sM2aZWfD+pK0rrr3mSoeKiHkxTugN2+aFuvOpo=
X-Gm-Gg: ASbGnctWjgWnGUNNhBAnAi/YiOKEQAuTpyZBw8Rt6PFalSEsfBBOmqoghu6nSBja/mX
	qoomGGJnDdSvofjQVJvKeKLWfw6O/I/gMiSySqE9QZOqsNot2ThuhAgj02YoQWt0l9sVgZFtew/
	Ow7reO59XFn9tMkXi5ohch4ftougo1cgsvVLrRDpEwU+60SryIEopnpJ6X8a6rUhLdmtL2hYxi7
	rZq7FLV5ZFJUOgPo8bDVw6JJA8sBvfoif0GBbx9QPI5u1NRHJxL3eoa9u7w4r4svNrfJWSR4Rnk
	ZH3NWM2EHodM3XOuqjh8GqKpZxa0XuRXoVJ+WEg1QGcLaFj95XnMnrTvQ1BVvUqTaoghRqiP3Mr
	7SdT8F9YpOmHoKilBqR5BTWO+cavkM8cqpgT7CIwkogOPolvAw1LPHpznLVGesgeAsf2hpDlG4D
	vts8pKAsI9XLqAwg5OXR3r47uEqatyNXpprLXswZzUh31abX54JGM5bxvfnBNpXv9iWDfWgg==
X-Google-Smtp-Source: AGHT+IEMapVQRI0ck2KCGxvEYuBB3a+08a/2JspNz86EbcND1SGuRInp+B2xwxF3NumJMeFQLVJPkQ==
X-Received: by 2002:ac8:5883:0:b0:4e8:99b0:b35e with SMTP id d75a77b69052e-4e89d263140mr4179321cf.30.1760624250594;
        Thu, 16 Oct 2025 07:17:30 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8955b07e9sm13309541cf.27.2025.10.16.07.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:17:29 -0700 (PDT)
Date: Thu, 16 Oct 2025 10:17:25 -0400
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
Message-ID: <aPD-dbl5KWNSHu5R@gourry-fedora-PF4VCD3F>
References: <20250827175247.83322-2-shivankg@amd.com>
 <20250827175247.83322-9-shivankg@amd.com>
 <aNVQJqYLX17v-fsf@google.com>
 <aNbrO7A7fSjb4W84@google.com>
 <aPAWFQyFLK4EKWVK@gourry-fedora-PF4VCD3F>
 <aPAkxp67-R9aQ8oN@google.com>
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
In-Reply-To: <aPAkxp67-R9aQ8oN@google.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Oct 15, 2025 at 03:48:38PM -0700, Sean Christopherson wrote:
> On Wed, Oct 15, 2025, Gregory Price wrote:
> > why is __kvm_gmem_get_policy using
> > 	mpol_shared_policy_lookup()
> > instead of
> > 	get_vma_policy()
> 
> With the disclaimer that I haven't followed the gory details of this series super
> closely, my understanding is...
> 
> Because the VMA is a means to an end, and we want the policy to persist even if
> the VMA goes away.
> 

Ah, you know, now that i've taken a close look, I can see that you've
essentially modeled this after ipc/shm.c | mm/shmem.c pattern.

What's had me scratching my chin is that shm/shmem already has a
mempolicy pattern which ends up using folio_alloc_mpol() where the
relationship is

tmpfs: sb_info->mpol = default set by user
  create_file: inode inherits copy of sb_info->mpol
    fault:    mpol = shmem_get_pgoff_policy(info, index, order, &ilx);
             folio = folio_alloc_mpol(gfp, order, mpol, ilx, numa_node_id())

So this inode mempolicy in guest_memfd is really acting more as a the
filesystem-default mempolicy, which you want to survive even if userland
never maps the memory/unmaps the memory.

So the relationship is more like

guest_memfd -> creates fd/inode <- copies task mempolicy (if set)
  vm:  allocates memory via filemap_get_folio_mpol()
  userland mmap(fd):
  	creates new inode<->vma mapping
	vma->mpol = kvm_gmem_get_policy()
	calls to set/get_policy/mbind go through kvm_gmem 

This makes sense, sorry for the noise.  Have been tearing apart
mempolicy lately and I'm disliking the general odor coming off
it as a whole.  I had been poking at adding mempolicy support to
filemap and you got there first.  Overall I think there are still
other problems with mempolicy, but this all looks fine as-is.

~Gregory

