Return-Path: <linux-erofs+bounces-1990-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF990D3A1CF
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 09:40:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvkRt2Vf1z2xSZ;
	Mon, 19 Jan 2026 19:40:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::22e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768812026;
	cv=none; b=DLJHPr6906iY6KpjAklEc0kw/bQv/aw2c9As3XA3eJkmI93vRFnTJJe94zESocwZBjMVnLkZtdz7+5vFsFHC1prQi3sl1vuqjmEqT6DFFX35xj6NeWQbVphlUUadcAJP8KmZ1RjVxnPQb2p8baLlPmNL9eOiXFJ+SyFzG001O3ixC0SKgmPcNVUyGP0DfSyVSlVXljVtKycdU6ogUi/zk2pb/4z4LszGm5lEraV6TewJYPkA+OGPTnaIct9jOWaTIQ5tIk9piX8afT49vkPGQ0va3cn+HHSq1jjGomYAVczl0HBLiKRNj+pT/iK9MYUryBiEiLfYyKh635Mhqcc+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768812026; c=relaxed/relaxed;
	bh=KJoYOa5K18nqNKCWxkYAOdRPH4EyPY3p5tSvazTt+nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3TrzS0hjeSPLN7YgqG4qVIjbBNKJTmzcpoNIw40q1WoY02qM9EgH6/dFn4a+NJLPv/O0T+iU2Cevk8idUdfcvx95NL8ApJs0XkP3o2fW/N4EezUNW8PdUECzIXA6lG+w/MIEYw/JuJf37APLFSEGi3qZR8nHAa0x6YhygJI2g/AYadhjZQvbHRfiEgeHTztZc/RSt6BvMBgqYkFnyKv3iQz11RQoJwbZs/QPcPs1bc/qv+G3Rn+fy0nUqEjaKod25lnCzEQihybKrPLhcdO13X24tXDKw8Eq7T/Pb0DdeMZnGT91Oyr80i+Gm4PbC1c1HBjoe2dbHAeXZw3+F7kVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MC1kuHuc; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::22e; helo=mail-lj1-x22e.google.com; envelope-from=konishi.ryusuke@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MC1kuHuc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::22e; helo=mail-lj1-x22e.google.com; envelope-from=konishi.ryusuke@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvkRr3ZLGz2xHW
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 19:40:23 +1100 (AEDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-38304020185so33108041fa.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 00:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768812015; x=1769416815; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJoYOa5K18nqNKCWxkYAOdRPH4EyPY3p5tSvazTt+nc=;
        b=MC1kuHucgZXXMBLvDAGcdmDla2R1AMpWfUKpJMavwJrk9erX8oCaePYBdy6GyWLKbM
         q6MmthQN8ZrznIVNoax/aHVfRk5Z8LM+8BtoP/XIZHlqqCUGCIcYvRbnC4fJiDqLqJwb
         DmcJsv+kAqm2P6DEl49Dav+82hXdNNfHMp45UqAXrKr42AH1sWf8atqOB6u2oH3IRb0J
         akzJIBcpHyJRYIjzW253l0PKOTt3/JqOeSIpQSaVAuYLhCH+HglscEhuAECV1kbuf2YA
         F+s8T1u94kyzuHsNPgDfJyLAIyhnoReIb9/I27hEBiJ9bS/Knjlua2Fk4uKnV558fXfq
         qqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768812015; x=1769416815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KJoYOa5K18nqNKCWxkYAOdRPH4EyPY3p5tSvazTt+nc=;
        b=ja2li615F1T2M1Fsvjy8KF0dmlAQ6J2qwBbTMh3ho/lmwA6deV88qIMsg2zpZqGgBB
         4P+orf4aJe6hcpIx1hFBMC2wPXenvLdm0N3Vcphq8LBhnFzO8ruFVkWk3dTFWabzvAL8
         E/clc7eqPX7X2zdh4FY4ulgJafDfr5jwCtUg7fPdZ0C36ljR9AEGvLBtJTDeyD1OOxLR
         naoYzRRPB/0MdnonZJXa+v0kJTAcQr/FjW9n5/U9un1eOxvnL55zclWkEpAG224KzQhz
         /FbrrAeqZ0u3iRHtLt3F16Q0RjkanCmMB07+OTWncePkGJtLCyyqw41UpjFedncEAFcS
         eteQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaqWtcpL1hWI7jlnYRL0WrHX7c/2Lvc9fbCwdw6Y9er1q1V5oNsDNy50/wuvGriAxfnEtIrkUmhd537A==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyYwJ9yeh2gLECpObRfLs2JskMtwZxGEqHT/IY72R870Ti34NdA
	JQOH/SB5HZLOpLigrHlKQN9WogtAsebb4DUWeJbQHkTee4V/GLH55EGw88JW1cC1TEuFIhchn+p
	mzupYWmlrZLJ8ULpD9R4sDXPHuC7S2ZQ=
X-Gm-Gg: AY/fxX5kOyL9u93alm4Um7L/o2HkAzRgz/wZ4VJIGOVMrzyJ3tjimYx25jx40RaV61q
	CwBbIM0i+9wt380Dyk27bG66PnNwSm4TzL4+AfWc2TQz6CsmabLrOFLQluBHAec7Fuk84LHI8wf
	omnrVfEZ8Zb4TVhyd8aJNv8glU+zlMBqHoZoMUkWrlfzir5D0fR7uoM3PkcwXlpc9c3jswBJMo1
	A0abORhtaH+eRucw4GHADKnCHk5h5RovXm3WPAtHmg8XLwU2Z9o9NcItk1JWfRJj9gL5ir0
X-Received: by 2002:a05:651c:31d3:b0:37b:9ab6:a071 with SMTP id
 38308e7fff4ca-383842a1f56mr38777111fa.28.1768812014411; Mon, 19 Jan 2026
 00:40:14 -0800 (PST)
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
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org> <20260115-exportfs-nfsd-v1-20-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-20-8e80160e3c0c@kernel.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Mon, 19 Jan 2026 17:39:57 +0900
X-Gm-Features: AZwV_QgvoiJk-4c_7XszNQLNhAbjR94vrEkk8toY4eDKXl6u9TqMllUY3n06aqo
Message-ID: <CAKFNMomS-8MMAjy8yuFwzuLBuQQA8r7gPJeJh1ci6RvVc9u4EA@mail.gmail.com>
Subject: Re: [PATCH 20/29] nilfs2: add EXPORT_OP_STABLE_HANDLES flag to export operations
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Amir Goldstein <amir73il@gmail.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org, 
	devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, Jan 16, 2026 at 2:50=E2=80=AFAM Jeff Layton wrote:
>
> Add the EXPORT_OP_STABLE_HANDLES flag to nilfs2 export operations to indi=
cate
> that this filesystem can be exported via NFS.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi

