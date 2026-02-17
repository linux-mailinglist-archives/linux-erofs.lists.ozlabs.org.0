Return-Path: <linux-erofs+bounces-2325-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPRmNkXalGlyIQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2325-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Feb 2026 22:14:45 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4986D1509A3
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Feb 2026 22:14:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fFspp0c8nz2xGF;
	Wed, 18 Feb 2026 08:14:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771362882;
	cv=none; b=g21dLySQxFdJxS8avy7V+NKxyQrFMQSjgz24WQPM+Voy0d2zFjbLMoKGUchRP8ozcnGCB4pzegxB5UuoMZl8leCQ2t2rP8m1EvJm6zbaprleekNSU/IAliQcrkocsR4MDekBLNjZ0edHIKFMvDVgfJMskRtnMnWYfrpbQQmmCipSrEdKDv3lSDgw+ivUKnh5Pa98xWgSvmwrEgS7f54JOqB9hbAxM7IYEXCpfH9MrisHvsNxgzrg7oB2tiKsvR1noL5upl+pj9LuUZBMeQnoC1Ju8GCO+495zkdQ1CsDpBmVoJf8FxDwnGxo2iXSiSRM8bZhcnhn+YEFspH2xp61DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771362882; c=relaxed/relaxed;
	bh=/QAFZrzsR3b01tUvyixH463bVn8gaQeXSmMleluN4G8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UzKlAn8TEeCx5QMOaBxtzB9DRoEq415CKU4XSij3MTyMpBDnPB+qRRJ1fgvJnKSvSxL0QPA4A1KfYSfIF9QKGh+9V/2HOWGnV5jBWSkrC4l0dFPqJaSoYPG0xs3KlMHrLdb1BhJ+MT7HyVI2m4KMadunc8i7HFMH4OCqR5RFhL+fCcsv4z4hdbglhYHzhfdUQmSLEkb6hmDuR0ArWAZwaF+xaPSly0X8sA7u7pZZnxwmxCiKFC4eiovVuDUhfQ8Y4zHyxCJx8K9baiBZh1RPMTEzkDS0QMGFDqhc9wtaLO2+P3vEaBGJOmkkemSXMUxLGgekM5WQomKqoEeG6bAAqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qME5lVPC; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+f2fs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qME5lVPC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+f2fs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fFspn0kmZz2x99
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Feb 2026 08:14:40 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5CA3D60128;
	Tue, 17 Feb 2026 21:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05413C19421;
	Tue, 17 Feb 2026 21:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771362878;
	bh=SWr3Pg6zIeu2S3Z6UDsk8BzZU6tf527GPJ41POMlghM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qME5lVPCgbs75GtVkYDVSedStUuy5Pu7iKCY4IKu3xqN3EcQE+Oh5yA77hoZy7VyU
	 +0wZZYMpZQVXM9oVuFBmRCNz9ULENuT2B5em0ouDg88Yb0OXaPujVB/GBPkgNNMpHr
	 EhgPO+uLpu1WI515RTCnoSYcSuoUoWHPdRcl280BUTS4HjHiimnSyoFiD+9+NmEu7s
	 4m0WVXB/a1C6i48qotqtPrvf49sFdMixg5MNCldkNycO7JhTW+IJtnP0WEfZw+8dYi
	 1uYBY6iDz7huxRyc2w6LATusfRgMkVW0RAKYcp9Uufer3E7jADONKO2Apo8cM0wFiU
	 pB1OIFY+N5Jzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B1123806667;
	Tue, 17 Feb 2026 21:14:31 +0000 (UTC)
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
Subject: Re: [f2fs-dev] [PATCH 00/24] vfs: require filesystems to explicitly
 opt-in to lease support
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <177136286957.643511.1991968143318289235.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 21:14:29 +0000
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
In-Reply-To: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: luisbg@kernel.org, salah.triki@gmail.com, nico@fluxnic.net,
 hch@infradead.org, jack@suse.cz, al@alarsen.net, viro@zeniv.linux.org.uk,
 brauner@kernel.org, dsterba@suse.com, clm@fb.com, xiang@kernel.org,
 chao@kernel.org, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, lihongbo22@huawei.com, guochunhai@vivo.com,
 jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
 hirofumi@mail.parknet.co.jp, dwmw2@infradead.org, richard@nod.at,
 shaggy@kernel.org, konishi.ryusuke@gmail.com, slava@dubeyko.com,
 almaz.alexandrovich@paragon-software.com, mark@fasheh.com,
 jlbec@evilplan.org, joseph.qi@linux.alibaba.com, hubcap@omnibond.com,
 martin@omnibond.com, miklos@szeredi.hu, amir73il@gmail.com,
 phillip@squashfs.org.uk, cem@kernel.org, hughd@google.com,
 baolin.wang@linux.alibaba.com, akpm@linux-foundation.org,
 linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
 chuck.lever@oracle.com, alex.aring@gmail.com, agruenba@redhat.com,
 corbet@lwn.net, willy@infradead.org, ericvh@kernel.org, lucho@ionkov.net,
 asmadeus@codewreck.org, linux_oss@crudebyte.com, xiubli@redhat.com,
 idryomov@gmail.com, trondmy@kernel.org, anna@kernel.org, sfrench@samba.org,
 pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
 tom@talpey.com, bharathsm@microsoft.com, hansg@kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, linux-mm@kvack.org,
 linux-mtd@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nilfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev,
 ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev,
 samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2325-lists,linux-erofs=lfdr.de,f2fs];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,fluxnic.net,infradead.org,suse.cz,alarsen.net,zeniv.linux.org.uk,suse.com,fb.com,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,mail.parknet.co.jp,nod.at,dubeyko.com,paragon-software.com,fasheh.com,evilplan.org,omnibond.com,szeredi.hu,squashfs.org.uk,linux-foundation.org,samsung.com,sony.com,oracle.com,redhat.com,lwn.net,ionkov.net,codewreck.org,crudebyte.com,samba.org,manguebit.org,microsoft.com,talpey.com,lists.sourceforge.net,vger.kernel.org,lists.linux.dev,kvack.org,lists.infradead.org,lists.orangefs.org,lists.samba.org,lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:luisbg@kernel.org,m:salah.triki@gmail.com,m:nico@fluxnic.net,m:hch@infradead.org,m:jack@suse.cz,m:al@alarsen.net,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:dsterba@suse.com,m:clm@fb.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:jack@suse.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:jaegeuk@kernel.org,m:hirofumi@mail.parknet.co.jp,m:dwmw2@infradead.org,m:richard@nod.at,m:shaggy@kernel.org,m:konishi.ryusuke@gmail.com,m:slava@dubeyko.com,m:almaz.alexandrovich@paragon-software.com,m:mark@fasheh.com,m:jlbec@evilplan.org,m:joseph.qi@linux.alibaba.com,m:hubcap@omnibond.com,m:martin@omnibond.com,m:miklos@szeredi.hu,m:amir73il@gmail.com,m:phillip@squashfs.org.uk,m:cem@kernel.org,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:akpm@linux-foundation.org,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:yuezhang.mo@sony.
 com,m:chuck.lever@oracle.com,m:alex.aring@gmail.com,m:agruenba@redhat.com,m:corbet@lwn.net,m:willy@infradead.org,m:ericvh@kernel.org,m:lucho@ionkov.net,m:asmadeus@codewreck.org,m:linux_oss@crudebyte.com,m:xiubli@redhat.com,m:idryomov@gmail.com,m:trondmy@kernel.org,m:anna@kernel.org,m:sfrench@samba.org,m:pc@manguebit.org,m:ronniesahlberg@gmail.com,m:sprasad@microsoft.com,m:tom@talpey.com,m:bharathsm@microsoft.com,m:hansg@kernel.org,m:jfs-discussion@lists.sourceforge.net,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gfs2@lists.linux.dev,m:linux-mm@kvack.org,m:linux-mtd@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nilfs@vger.kernel.org,m:linux-ext4@vger.kernel.org,m:devel@lists.orangefs.org,m:ocfs2-devel@lists.linux.dev,m:ceph-devel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:v9fs@lists.linux.dev,m:samba-technical@lists.samba.org,m:linux-unionfs@vger.kernel.org,m:linux-f2fs-devel@lists.sourceforge.net,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.
 org,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-btrfs@vger.kernel.org,m:salahtriki@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[86];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 4986D1509A3
X-Rspamd-Action: no action

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Thu, 08 Jan 2026 12:12:55 -0500 you wrote:
> Yesterday, I sent patches to fix how directory delegation support is
> handled on filesystems where the should be disabled [1]. That set is
> appropriate for v6.19. For v7.0, I want to make lease support be more
> opt-in, rather than opt-out:
> 
> For historical reasons, when ->setlease() file_operation is set to NULL,
> the default is to use the kernel-internal lease implementation. This
> means that if you want to disable them, you need to explicitly set the
> ->setlease() file_operation to simple_nosetlease() or the equivalent.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,01/24] fs: add setlease to generic_ro_fops and read-only filesystem directory operations
    https://git.kernel.org/jaegeuk/f2fs/c/ca4388bf1d9e
  - [f2fs-dev,02/24] affs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/663cdef61a27
  - [f2fs-dev,03/24] btrfs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/f9688474e413
  - [f2fs-dev,04/24] erofs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/f8902d3df893
  - [f2fs-dev,05/24] ext2: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/ccdc2e0569f5
  - [f2fs-dev,06/24] ext4: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/20747a2a29c6
  - [f2fs-dev,07/24] exfat: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/b8ca02667552
  - [f2fs-dev,08/24] f2fs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/9e2ac6ddb397
  - [f2fs-dev,09/24] fat: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/a9acc8422ffb
  - [f2fs-dev,10/24] gfs2: add a setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/3b514c333390
  - [f2fs-dev,11/24] jffs2: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/c275e6e7c085
  - [f2fs-dev,12/24] jfs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/7dd596bb35e5
  - [f2fs-dev,13/24] nilfs2: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/f46bb13dc5d9
  - [f2fs-dev,14/24] ntfs3: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/6aaa1d6337b5
  - [f2fs-dev,15/24] ocfs2: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/f15d3150279d
  - [f2fs-dev,16/24] orangefs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/136b43aa4b16
  - [f2fs-dev,17/24] overlayfs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/94a3f60af5dc
  - [f2fs-dev,18/24] squashfs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/dfd8676efe43
  - [f2fs-dev,19/24] tmpfs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/f5a3446be277
  - [f2fs-dev,20/24] udf: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/dbe8d57d1483
  - [f2fs-dev,21/24] ufs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/545b4144d804
  - [f2fs-dev,22/24] xfs: add setlease file operation
    https://git.kernel.org/jaegeuk/f2fs/c/6163b5da2f5e
  - [f2fs-dev,23/24] filelock: default to returning -EINVAL when ->setlease operation is NULL
    https://git.kernel.org/jaegeuk/f2fs/c/2b10994be716
  - [f2fs-dev,24/24] fs: remove simple_nosetlease()
    https://git.kernel.org/jaegeuk/f2fs/c/51e49111c00b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



