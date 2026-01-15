Return-Path: <linux-erofs+bounces-1930-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BCCD28A5F
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 22:09:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsbGG0xJHz2xGF;
	Fri, 16 Jan 2026 08:09:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::441"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768511382;
	cv=none; b=BXt4/NAHaGEx+WmfNjFUeHD26pQvXUxW5izolbuZWf0AtTebkpIld2dPHRkNnfjYSLgV0ZMvY7qirhC34eiFv+WqtpMl6sUjL6mbj+4MAIB7dYSeStAdK1Li+AejEf34uoGb32/9QeaxeAKPq/vT6PrR2gK+ByuH/2YgswG8x9hKu2j7sarrucF248pnE3+tEiX5hBOh48YZT+skmathWnj+DNmw63oFaauCbf8s+lT5gylHJNT38tHeiqiIvGl3mF38od8M14yj/SwSTg7PLPdm9VCCQ+jK7xBfisY5qXIGsJZqCHTSEjFgFmkDSQF9wSo2YMjqU1VMBMT4Psd6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768511382; c=relaxed/relaxed;
	bh=9qNaS/mHG0CWRhBXyo18LMgHGDC++HAHg2FdEUDjFsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLND6/S3W5PukkyQEstwaED7N0OnBsak2PTL1Cc8PzNeA46Kww9EGbDm7ntQJGZ15kK7EISCuA2FDiaU0Dm2sOWfhtjgzHKc7imQAigE6WGwXdeAe2+MwhGnswp6d19TA46Sb4fbB/vcnq5jrpLWh9DLb6PxOrSkYdS9DEWsbSEApGMJPwGh6bprDXe1weF2G1obfNfxeCqdksJEbQ1cQReTB5arfjPWaJaiWnn1Yk6jY6+L+tBwZ+V0fTI7C2WQVkteQ2NQ1ZDPnoEQIy95nxo7kGX4+dLf/dLcdsoPqtxzfpstQF/A52K+uGjVZPKFKwTMnBU0ESKw+p8T5sngFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=EPlPxCV3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org) smtp.mailfrom=fromorbit.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=EPlPxCV3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsbGD3CcGz2xBV
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 08:09:39 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-81f4ba336b4so1226192b3a.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 13:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1768511376; x=1769116176; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9qNaS/mHG0CWRhBXyo18LMgHGDC++HAHg2FdEUDjFsI=;
        b=EPlPxCV3HVplkG0dxUbClFdmO54uClC6fuwnsfoImBnF09s5t/Fkc4uMJ43uIdy1/a
         EzFvMfZhKBCveJye6CYCuQgHYKHQCsC7TZ0p7HKRuHO36KlhjM5KAoOVeAHso7AQ8T+6
         aD0/U4BfvQvam7cTCT0LsoUp+JQIJVYKAoFkaPSdII+cGLj9gBj3Vjvbyvpj3Sl/YHQa
         oL8FlVpbBNmMZBbwvrmwE2j7vlVogifpsbrLW+MY8a1f6kA6b2uk+hOp488Ha1AIEz45
         ePDSFTX5RyhQSJZQwpFc2714ow1ACc28P4hOkCeYJ9ac9yuSXk95LNFrSY1CbCQC/+yD
         77YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768511376; x=1769116176;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qNaS/mHG0CWRhBXyo18LMgHGDC++HAHg2FdEUDjFsI=;
        b=p5uAJEYzjEBG2HHrJCK3+NkU/mIYJyxeRFo0T8Q/woVeTtbzyp/CmJmmaODedT+8wo
         za1nr7t0Csnb50/CY15vlmN1hwHpdNu1vmHmd+ERNykhtNrJZlbUpj96YWrIqUN9B7ZR
         S7fmpSD6h57bonc3PEtmub5TjLIL5TrnrNcUonRYbHRzvzxZh+ItaEtCHHZuoxvSkgir
         /JF+Fo1Y3H7b3orfKoDT/IVU3Jrad+ui3Gmo+NbqlslIx7E581UQnzkAQ59o2+JuAnwz
         bfSJlO2CgZRUG8xzj890WHjIX/TaI6d89iwyH5PpM1U8iYcPxWpyZKN1vVHLzJipTpFi
         rwDg==
X-Forwarded-Encrypted: i=1; AJvYcCWLsM24NMNHOsdF8Foj4MrXmfKHCwnQddEE6VyHtMyfyGDTnjPTMsnmyi3FOc3zjGlgHTEaEMNAciev6g==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yym4dr2ZeUogT2zbnnuqwA+4Kwih9Ge3Sh0LnsxfCQPP9XMN/i5
	PfkLaXu1aRzJ3+md2YJhXzRIJ/RPKKZ0ZnD3gyxus4fqedZued6t8higefkwHZ7MuJo=
X-Gm-Gg: AY/fxX5lkoLaJPvMrvTQsxmHsciPStT4nsOMnbqWQqW7LmPUGU2FnGCTAHe2XlqJj38
	OcrVzVXxQvJXT/tW7+5o6HiGBbCGYRH+9H1b5nld/fUbVp/7019QclaLYMswFduUnQ4z1VLi5ax
	Po3M6RbTNZP+F2p6Gl753I1qq5igeH2SluucNyPfaeewGfjC0e3qnlNvzaSteu20Ufs4kdxOhDI
	RubZDizxV5fOAfCGR71gQneU0A3YWY8sFy+ti+2xYv5aSFszTZbrXQALKkHxHq/HwiwVx1nSjtK
	I6umTW0XNDM1M1du5nZq0T0/Bd7eFIagvWKRWATAPHI/mDJUJk/Nb8qQBigXUVrFxOQCoeqEHMS
	fmmR8xI3u3LhR4rt0o4Fx9Betb9qBQEsGZIbI2b0pLUR3+OscdBgrPMRCpJavRDW2L/3gXzeCUO
	hZRujMI3TZYU0J8Jl3UQW052s/Kie1J2idc0ffP+VDIIAs04AUNFhMKzwbvbIG2/c=
X-Received: by 2002:a05:6a00:1c99:b0:81e:5d52:53b9 with SMTP id d2e1a72fcca58-81f9f7f61bamr693898b3a.8.1768511376156;
        Thu, 15 Jan 2026 13:09:36 -0800 (PST)
Received: from dread.disaster.area (pa49-180-164-75.pa.nsw.optusnet.com.au. [49.180.164.75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10bda5csm259171b3a.19.2026.01.15.13.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 13:09:35 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.99.1)
	(envelope-from <david@fromorbit.com>)
	id 1vgUai-00000003vHn-2AU2;
	Fri, 16 Jan 2026 08:09:16 +1100
Date: Fri, 16 Jan 2026 08:09:16 +1100
From: Dave Chinner <david@fromorbit.com>
To: Chuck Lever <cel@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>, Carlos Maiolino <cem@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-unionfs@vger.kernel.org, devel@lists.orangefs.org,
	ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev,
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
Message-ID: <aWlXfBImnC_jhTw4@dread.disaster.area>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com>
 <CAOQ4uxhnoTC6KBmRVx2xhvTXYg1hRkCJWrq2eoBQGHKC3sv3Hw@mail.gmail.com>
 <4d9967cc-a454-46cf-909b-b8ab2d18358d@kernel.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d9967cc-a454-46cf-909b-b8ab2d18358d@kernel.org>
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, Jan 15, 2026 at 02:37:09PM -0500, Chuck Lever wrote:
> On 1/15/26 2:14 PM, Amir Goldstein wrote:
> > On Thu, Jan 15, 2026 at 7:32 PM Chuck Lever <cel@kernel.org> wrote:
> >>
> >>
> >>
> >> On Thu, Jan 15, 2026, at 1:17 PM, Amir Goldstein wrote:
> >>> On Thu, Jan 15, 2026 at 6:48 PM Jeff Layton <jlayton@kernel.org> wrote:
> >>>>
> >>>> In recent years, a number of filesystems that can't present stable
> >>>> filehandles have grown struct export_operations. They've mostly done
> >>>> this for local use-cases (enabling open_by_handle_at() and the like).
> >>>> Unfortunately, having export_operations is generally sufficient to make
> >>>> a filesystem be considered exportable via nfsd, but that requires that
> >>>> the server present stable filehandles.
> >>>
> >>> Where does the term "stable file handles" come from? and what does it mean?
> >>> Why not "persistent handles", which is described in NFS and SMB specs?
> >>>
> >>> Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
> >>> by both Christoph and Christian:
> >>>
> >>> https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-12018e93c00c@brauner/
> >>>
> >>> Am I missing anything?
> >>
> >> PERSISTENT generally implies that the file handle is saved on
> >> persistent storage. This is not true of tmpfs.
> > 
> > That's one way of interpreting "persistent".
> > Another way is "continuing to exist or occur over a prolonged period."
> > which works well for tmpfs that is mounted for a long time.
> 
> I think we can be a lot more precise about the guarantee: The file
> handle does not change for the life of the inode it represents. It

<pedantic mode engaged>

File handles most definitely change over the life of a /physical/
inode. Unlinking a file does not require ending the life of the
physical object that provides the persistent data store for the
file.

e.g. XFS dynamically allocates physical inodes might in a life cycle
that looks somewhat life this:

	allocate physical inode
	insert record into allocated inode index
	mark inode as free

	while (don't need to free physical inode) {
		...
		allocate inode for a new file
		update persistent inode metadata to generate new filehandle
		mark inode in use
		...
		unlink file
		mark inode free
	}

	remove inode from allocated inode index
	free physical inode

i.e. a free inode is still an -allocated, indexed inode- in the
filesystem, and until we physically remove it from the filesystem
the inode life cycle has not ended.

IOWs, the physical (persistent) inode lifetime can span the lifetime
of -many- files. However, the filesystem guarantees that the handle
generated for that inode is different for each file it represents
over the whole inode life time.

Hence I think that file handle stability/persistence needs to be
defined in terms of -file lifetimes-, not the lifetimes of the
filesystem objects implement the file's persistent data store.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

