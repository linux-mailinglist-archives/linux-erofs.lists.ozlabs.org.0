Return-Path: <linux-erofs+bounces-1803-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A09B3D0CC48
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Jan 2026 02:48:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dp1kD3t89z2yD4;
	Sat, 10 Jan 2026 12:48:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768009684;
	cv=none; b=iupwpcKrY+zjrLqQKrh7TNb6GIq14qDOUwyrsXS6zulMu/yMcoA60073ojGl8nn+Yk25kglTxuWHj+82gt98ld0cukKZ0zMK38N7bFZotRuEW0+QS+xUsjeYD9nQMT5PxurYiXE5uc05mZqEBuNiQXq4n5UFMvvdUMKF/Z5xNM2yL00CloezMcTSN/lW5HIVeJ/dIQKqj5O8UXCMaabE544Y06JDo7kQ+FWQce8ynYlrkUvjhdSJXRT/MfxJwLKl3QNwIe5khPc7tRXfobIBraJcL0LAxEGoUFZLulTyw1cheOZPpixd67jQVm5bp/ek1EEgiqxoX72vxdcKsxRENw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768009684; c=relaxed/relaxed;
	bh=AGJ7du8VQFjwWoJPHie5gQy0pHDdQ8AKRzAoeeB3cHU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GLIzn+kPVMBLUbP87vYt3VmwCTZHq/78Jh5f9KuAo4yTMUXsru29CDwcNoKbYHCH2mia35q+opukTZBHeUwdlDX0atdnKoGzZIHr1WBy7ZeWwzy6UyDM/26xgu9FUjuq3agoZoy6mG/97y5qoeXNhF1FgjTPCijbOpaY1kSV3AW/i/qG3HVjIcEirPTDu6oAbgSxkc7/a7sKb88qStC2l6QMen3igLP9iG1BVYboM106CxIrHP3OcDE6mrDFfFrRRrLUB5uwdoMKj3dxz84jxQnW3eHkAiGQPbfXiRxqIpkcE1pyScbYHIysSbQxn0sXVITOgFSLYHI4BnFlG2Bm6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Fu7FxrUR; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Fu7FxrUR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dp1kC5TS4z2xrM
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Jan 2026 12:48:03 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1AC574021D;
	Sat, 10 Jan 2026 01:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAB1C16AAE;
	Sat, 10 Jan 2026 01:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768009682;
	bh=cdF01HTymcjwXfQS8AcBirvW01pDXmvEycM3L47DM38=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Fu7FxrURqv63o/6rCcdW5OUCW4q5tJDwdMX16lkstwj96Y3ue96Q6p+PXYcAkBSTE
	 UuBIQcMoCb8UBhZ3VgYGY9Hs+mposZy8O/TAd1t9B2FHXb83g+J13cZy/S+COvLI7A
	 AVzdxtl+7sZ+ARe92YM2Pq5SJrqPzbyS3fbZcI0XyVKr6eLq08Q3Rx/Lu5Az1QejVf
	 c5L1AD5mIN6/tM9/vPJ6O4DOb+2koTVlkEeccrf23n1J/Asfg2W7yZt4cZtExuiJ/F
	 dREajCpoYlb46NKuspiGJYA2YFWhQ/LnSHS5B/M4V94u/4Hn/t/pnkaQiawh8m0Fnu
	 nh/QGL+jmgSBA==
Message-ID: <772e9b7d-6d83-4495-864d-f506211a9d62@kernel.org>
Date: Sat, 10 Jan 2026 09:47:58 +0800
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
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org,
 jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
 devel@lists.orangefs.org, linux-unionfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, gfs2@lists.linux.dev,
 linux-doc@vger.kernel.org, v9fs@lists.linux.dev, ceph-devel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org
Subject: Re: [PATCH 08/24] f2fs: add setlease file operation
To: Jeff Layton <jlayton@kernel.org>, Luis de Bethencourt
 <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>,
 Nicolas Pitre <nico@fluxnic.net>, Christoph Hellwig <hch@infradead.org>,
 Jan Kara <jack@suse.cz>, Anders Larsen <al@alarsen.net>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>,
 Chris Mason <clm@fb.com>, Gao Xiang <xiang@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Jaegeuk Kim <jaegeuk@kernel.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>,
 Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Mike Marshall
 <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 Phillip Lougher <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>,
 Andreas Gruenbacher <agruenba@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, Xiubo Li
 <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM <bharathsm@microsoft.com>, Hans de Goede <hansg@kernel.org>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
 <20260108-setlease-6-20-v1-8-ea4dec9b67fa@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260108-setlease-6-20-v1-8-ea4dec9b67fa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 1/9/2026 1:13 AM, Jeff Layton wrote:
> Add the setlease file_operation to f2fs_file_operations and
> f2fs_dir_operations, pointing to generic_setlease.  A future patch will
> change the default behavior to reject lease attempts with -EINVAL when
> there is no setlease file operation defined. Add generic_setlease to
> retain the ability to set leases on this filesystem.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

