Return-Path: <linux-erofs+bounces-1761-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA9D06760
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 23:47:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnKmJ21w7z2yFd;
	Fri, 09 Jan 2026 09:47:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767912448;
	cv=none; b=nk67vrQPlPcfAVKU/MhM1E/wZE/0uD8uCbHPubpRXzaHFkXptEeklufgcGpHyBoeblkwkVFQl8Iq0r7tggnkq0vC3BmIUF8sxJdRdCzMejS++1mKDRVNloXpceSQO4ClXSOZvDmfQ8IOceYA9XKuaO3P6DG5HTPcacwsnlfZit1Z8+o7qyRPvYXJ/WK70M5urdn7/4WdbOHbeCPxUB82HdGh/+pMNLFjmwVGBalh2CWRelrdpDAdPtclbLPM3/NlPy2cz9daQP0xCE3RPo6M0urqe+BNSf9ePkJkxjqRYLD8r9eiJniz4eMsrTQnK+CViv7xuWezNCDs7nGt6CJzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767912448; c=relaxed/relaxed;
	bh=o8ABr/DNoRVjWLpEG3gYzt78FrDlsrlJ7hUxCqSBKIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkJTZ+Bvu7bDVr3PCsRzL+0FiezpLdpdCbbAW2cS7xuyLdjf2IRalSjciz1COwOkMMW+jCwdA4YFeuqS358i6fXsXh97iirFYeo6mCdXxlYYADvCgixe9bOzL9lraSgwVxEb8NTjzz1ueklga4/AQszz6Ff3bb5XgrElXCEWohK6BO8yV8w+1Vg1269M3v0fXM5UhSG9fPfVVwqAEdCuRoLWWxah7R7JpKptXJhf+rpr0F/WVxUdfFnf/01aiTe3biv8vBYAzfc58r8G0lv3kWqnvbkrV+MFIRBj5bPKspA7nMt20wvXFRNFA6ABVh/uUWC74eEGKz3d/rfNfIa69A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kNZ/y6ld; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linkinjeon@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kNZ/y6ld;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linkinjeon@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnKmH13wkz2xPL
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 09:47:27 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AE3C460163
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 Jan 2026 22:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801C9C2BCB0
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 Jan 2026 22:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767912444;
	bh=bpLucB2OVlqnpdSgR5fVsT/9lEifzVxq4+Kg3z371KE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kNZ/y6ld9T/Ac6XqHUpuWQ8PCKoHqDZK4KRIN0fR0qhZUAZgmdbhls/DOYhiAGX7z
	 lKJXMbj5kAIa3yPHcJzWdDqHLZWZUws36K4s8WUtTHBy0kZ1G+0Jbjoh7BgoGMTVB0
	 EHN+7t2qxXK5Wg9JwteHTuHVEx86cGwPSYmACkxAaR6cPMp9ZisNCP6MINj41SffBs
	 rGpQYrIDRH61Pi646aQVZ+ZmxyNbNF5rChS8TKq0svn+ns7GoUEV1FIGJpWNhiL7jz
	 wNVHZ83G97Pf5PZFUJN8TAkCmyWsi/CmvHe4Mf70Y4ziokGk5SSSZrPhqGGZMeQCS4
	 YWE8KQUzoe6Nw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8010b8f078so592893266b.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 14:47:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcaKa4zzD+sKvw3JSwa0IF69zBUbWMoeG589Y2R5ofJpeOQLKztjcbsekhSbZV5SbJXQHwsT4e0SVcYQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwXlj8vzFvsMBoeStSN/VdywRyb/W+vfqpvHLu7JAfwVq03W1Pn
	Z12yYNWBwhaj/Xla0TMeqyc/JoYQF2SJ/DHpcYQrE/F2l94OXSW8Ka0qfjGVTZZcCkO5O3VoPlQ
	kQMA9EDWHhJc85pzp0XRlFzf310Torpc=
X-Google-Smtp-Source: AGHT+IHRRvrZk+LJHsAd5/mP4TyTtkU5XrZgqXx3MfUuP0vWFtvlehE6tE5BFAh0/XFz8o1ILqvfmo203M6g5zkxlKk=
X-Received: by 2002:a17:907:c1e:b0:b72:c261:3ad2 with SMTP id
 a640c23a62f3a-b84451dab67mr854015966b.50.1767912442100; Thu, 08 Jan 2026
 14:47:22 -0800 (PST)
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
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org> <20260108-setlease-6-20-v1-7-ea4dec9b67fa@kernel.org>
In-Reply-To: <20260108-setlease-6-20-v1-7-ea4dec9b67fa@kernel.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 9 Jan 2026 07:47:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-JTE+233AwpvrXTsbfrbY+U_pvyUTQQSwz0mXh43jt=A@mail.gmail.com>
X-Gm-Features: AQt7F2q41Fu16p_9dWtEjvrFao8uwKCSAe9mKCbLxMeS3Ih2bsPKkzatUTosKic
Message-ID: <CAKYAXd-JTE+233AwpvrXTsbfrbY+U_pvyUTQQSwz0mXh43jt=A@mail.gmail.com>
Subject: Re: [PATCH 07/24] exfat: add setlease file operation
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
	Anders Larsen <al@alarsen.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	gfs2@lists.linux.dev, linux-doc@vger.kernel.org, v9fs@lists.linux.dev, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, Jan 9, 2026 at 2:14=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> Add the setlease file_operation to exfat_file_operations and
> exfat_dir_operations, pointing to generic_setlease.  A future patch
> will change the default behavior to reject lease attempts with -EINVAL
> when there is no setlease file operation defined. Add generic_setlease
> to retain the ability to set leases on this filesystem.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

