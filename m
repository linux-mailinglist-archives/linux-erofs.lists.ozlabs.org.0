Return-Path: <linux-erofs+bounces-1489-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BA0CB0B4A
	for <lists+linux-erofs@lfdr.de>; Tue, 09 Dec 2025 18:22:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dQlyW2QDFz2yF1;
	Wed, 10 Dec 2025 04:21:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765300915;
	cv=none; b=iayxZVYG4FvZwfs+jkZCwq5tApf/gK6l7W6Kp7X1er9IklG0uX6Q405lRt6tTF+gyGyzU6hnwOpCnWi1RR8Rv6IvozeLbrxxCMTv0OFw4zJ39SlO+ZEC+CeuQLlU6HYXRpMQ0qtf1q9yjTLL2luS+c2U/x5RMfm0yDSgQYiLPpJRr07HnpXSnkdol4F+FXSAdbsA3Nt6I4yjsXXXhwB+MKkxNtj675/tBCkJBvr4v9ad15Km7oEYykLXX4hfRzBkXC8JdHf/HCI18c3NWt9qFVPHLOtRt8wpJ9JHUr3tuW93D7xYNtCLkVWH5qSHkNoPGET3+TL/cIBDNIrsQRE0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765300915; c=relaxed/relaxed;
	bh=2OfZnJKQD65zAnOpqdjAiOAqDFP91IDQbUjGaeDV9mA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DR5c4fUqdBPZfan02Za4OjFSeKYrIxJpzEro3ikMoqxW4pF1zfTL6E/OPzlunWm3U0oIi12ne3wMa2p0lfijdE1gzPXFybTUIRYnAu/Nb/4rD9byV91icQ2Ev69SRng9EVWBxKuKDQk5edueDsMYXr/BNJ1tNQd0o5I+FLG13rgGc5FKvofrVA6EhTtQu8tRFOo8rwFHeoMjNFx0SArvxLNW/iTKmzNsR5oztiLkSqVo9pG6jYsObdHCD9oy+kHAaCxyTQlF2FOpeik7CZWGwPm1Ymf3AuoILFIIQIv0x2yJK0YmUufzJbfEyvKIWjr9swyCe5GmXWrGUoSwo9EePg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Psg4CKLA; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+f2fs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Psg4CKLA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+f2fs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dQlyV1sprz2xs1
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Dec 2025 04:21:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C0853601AF;
	Tue,  9 Dec 2025 17:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73601C4CEFB;
	Tue,  9 Dec 2025 17:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765300911;
	bh=6JzHwVMsw3oVBaLB929QEwdcMxFilfqVMX3zcgp6eKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Psg4CKLAi9h/A9vrvljHnRqp9p5yz8B5YCapKgSBCEr6kmloaOVwmNaYxp96nI0Jm
	 E1pbyJ1ln1w7L+cwykG7ZYqv4qRzAcWJFrrDoVllnAKtP9kV9HNNc0yvVFDPPFwIkZ
	 zlIrgsKzfz9N31t7zC7ENkzXvNMPaNLtaoUlwGSCq0lbSmlyoP3LMxcO1rKyc+86dE
	 NNhWUd3A/NHLJln9jL7sW0vI/gKw88UtIG56vYvOYlGCOJt2PmPeBPQ+WVB8pAbtZB
	 YUlzouJwNa/r7jfn9C9CtIGicL5PvCAPTPMpQEpILvgU65s/m796Uhb97EubDbNHcQ
	 BLbAhrtl11WCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B591F3808200;
	Tue,  9 Dec 2025 17:18:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
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
Subject: Re: [f2fs-dev] [PATCH kvm-next V11 0/7] Add NUMA mempolicy support
 for
 KVM guest-memfd
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176530072652.4018985.15391772848132749035.git-patchwork-notify@kernel.org>
Date: Tue, 09 Dec 2025 17:18:46 +0000
References: <20250827175247.83322-2-shivankg@amd.com>
In-Reply-To: <20250827175247.83322-2-shivankg@amd.com>
To: Garg@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Shivank <shivankg@amd.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, david@redhat.com,
 pbonzini@redhat.com, shuah@kernel.org, seanjc@google.com, vbabka@suse.cz,
 jgowans@amazon.com, mhocko@suse.com, jack@suse.cz, kvm@vger.kernel.org,
 dhavale@google.com, linux-btrfs@vger.kernel.org, aik@amd.com,
 papaluri@amd.com, kalyazin@amazon.com, peterx@redhat.com, linux-mm@kvack.org,
 clm@fb.com, ddutile@redhat.com, linux-kselftest@vger.kernel.org,
 shdhiman@amd.com, gshan@redhat.com, ying.huang@linux.alibaba.com,
 ira.weiny@intel.com, roypat@amazon.co.uk, matthew.brost@intel.com,
 linux-coco@lists.linux.dev, zbestahu@gmail.com, lorenzo.stoakes@oracle.com,
 linux-bcachefs@vger.kernel.org, apopple@nvidia.com, jmorris@namei.org,
 hch@infradead.org, chao.gao@intel.com, cgzones@googlemail.com,
 ziy@nvidia.com, rientjes@google.com, yuzhao@google.com, xiang@kernel.org,
 nikunj@amd.com, gourry@gourry.net, serge@hallyn.com, thomas.lendacky@amd.com,
 ashish.kalra@amd.com, chao.p.peng@intel.com, yan.y.zhao@intel.com,
 byungchul@sk.com, michael.day@amd.com, Neeraj.Upadhyay@amd.com,
 michael.roth@amd.com, bfoster@redhat.com, bharata@amd.com,
 josef@toxicpanda.com, Liam.Howlett@oracle.com, ackerleytng@google.com,
 dsterba@suse.com, viro@zeniv.linux.org.uk, jefflexu@linux.alibaba.com,
 jaegeuk@kernel.org, dan.j.williams@intel.com, surenb@google.com,
 tabba@google.com, paul@paul-moore.com, joshua.hahnjy@gmail.com,
 brauner@kernel.org, quic_eberman@quicinc.com, rakie.kim@sk.com,
 pvorel@suse.cz, linux-erofs@lists.ozlabs.org, kent.overstreet@linux.dev,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 pankaj.gupta@amd.com, linux-security-module@vger.kernel.org,
 lihongbo22@huawei.com, amit@infradead.org, linux-fsdevel@vger.kernel.org,
 vannapurve@google.com, suzuki.poulose@arm.com, rppt@kernel.org,
 jgg@nvidia.com
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Sean Christopherson <seanjc@google.com>:

On Wed, 27 Aug 2025 17:52:41 +0000 you wrote:
> This series introduces NUMA-aware memory placement support for KVM guests
> with guest_memfd memory backends. It builds upon Fuad Tabba's work (V17)
> that enabled host-mapping for guest_memfd memory [1] and can be applied
> directly applied on KVM tree [2] (branch kvm-next, base commit: a6ad5413,
> Merge branch 'guest-memfd-mmap' into HEAD)
> 
> == Background ==
> KVM's guest-memfd memory backend currently lacks support for NUMA policy
> enforcement, causing guest memory allocations to be distributed across host
> nodes  according to kernel's default behavior, irrespective of any policy
> specified by the VMM. This limitation arises because conventional userspace
> NUMA control mechanisms like mbind(2) don't work since the memory isn't
> directly mapped to userspace when allocations occur.
> Fuad's work [1] provides the necessary mmap capability, and this series
> leverages it to enable mbind(2).
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,kvm-next,V11,1/7] mm/filemap: Add NUMA mempolicy support to filemap_alloc_folio()
    (no matching commit)
  - [f2fs-dev,kvm-next,V11,2/7] mm/filemap: Extend __filemap_get_folio() to support NUMA memory policies
    https://git.kernel.org/jaegeuk/f2fs/c/16a542e22339
  - [f2fs-dev,kvm-next,V11,3/7] mm/mempolicy: Export memory policy symbols
    https://git.kernel.org/jaegeuk/f2fs/c/f634f10809ec
  - [f2fs-dev,kvm-next,V11,4/7] KVM: guest_memfd: Use guest mem inodes instead of anonymous inodes
    (no matching commit)
  - [f2fs-dev,kvm-next,V11,5/7] KVM: guest_memfd: Add slab-allocated inode cache
    (no matching commit)
  - [f2fs-dev,kvm-next,V11,6/7] KVM: guest_memfd: Enforce NUMA mempolicy using shared policy
    (no matching commit)
  - [f2fs-dev,kvm-next,V11,7/7] KVM: guest_memfd: selftests: Add tests for mmap and NUMA policy support
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



