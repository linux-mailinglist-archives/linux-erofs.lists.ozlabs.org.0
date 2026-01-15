Return-Path: <linux-erofs+bounces-1925-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B56D280FA
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 20:26:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsXzW52sMz2yFm;
	Fri, 16 Jan 2026 06:26:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768505207;
	cv=none; b=oiGght7qPH1gNAgyZLaI0KwpCV07/3VENK2Nd3cj82apPLSGCV1aq3klKly92zdQ/U1n8qAh8zpVVvW1KIac9J8N/8GCBrK/CEiFruOJgwS4b6tT4XAO4YItiatTczwllngoaFpai+T3mocZTWGmYA6K2kQuZtAHczSI6BC5laSL7F1E6Li41gEE7llOCUVnx/CkdZ9SuaMobMUKjU4zMReioZWHGCJNzXpwwWxhNl5Xm0Vjxj9z+8EVeCTpFbEx4+X7jEea1/snjpxpRj8r1mc3kr6TwbykC89HZpWMj4+VU88/i4d4iIKYSkrffmM3fZpqyznEPJ6sDc9zzyKlog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768505207; c=relaxed/relaxed;
	bh=aDUsn+SB7H7nYSne5YCtxozzRNZ3DAEsXPNjynL2NCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ao6eDVgrR9LqyNNqq/pcXiMR7xZUwsvZYGmEnGMvrgTEq+Y29RNOL0U30efgW6Rc9lixrSjP48qJHo0n3DJzb430WBMc9cCqqyO+7Ei6EXkSwdL2v5JrAaEPTzWUpGLRuotGFiAN06IurJ7+f9mLXVX0FBwsgjQSWDSdd397Iy2fyKkTnfYCv8d1y2X8imPJFW2svQGOhGgGKv6G4RGKyxkAu6FA9PKrTIHMWhH2R6SiXjM3OqJdDWxmarWHkOPyiJdzcztyN1BTmXUsKtU3nPGMhHEwvefVpnO9/SgWbx7BA/DkjN3ehXHxC/G2tpqH5+uTFVHut023R6erXbmxRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZO+5n6gM; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZO+5n6gM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsXzV2LSBz2xNg
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 06:26:46 +1100 (AEDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso1950618a12.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 11:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768505203; x=1769110003; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDUsn+SB7H7nYSne5YCtxozzRNZ3DAEsXPNjynL2NCs=;
        b=ZO+5n6gMHKVj6pp4hij8RBZ7pgKwbgFJ6br056Q1h5HOzfcN3DYdXbCvjm7j3LP18j
         PSqwueAwB/CpkaEoBlpfUYlqTrD8YYwatlAqxENgZeewYC8oH/rEdaJqmvNrvCoJG065
         YCPzAJ6W899MJ8y9F3owPiK2KFqBku/gqtm75ctTOQV6K0Oj2bdFoGOgV6VLdHgGdcqD
         E73f+a1GpEAvEMWIkI38NkaYA8w+zLMFjDHfHCqcrLlhFiqXCNuVXOHMzduhbRIKWcJg
         muS4R4XMf7za9yD4et1aGrz4yL43T4zDVgcsDFdmkUoKGEHLyMWwNbNHtPyyF9AvfS/U
         ckeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505203; x=1769110003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aDUsn+SB7H7nYSne5YCtxozzRNZ3DAEsXPNjynL2NCs=;
        b=TbZx4nmG4nYrCHrP+n5RLW5Ar+ckvkhfwNMcrwY1gqL0aRgPm9pWSG4grO++6QbYVH
         ZYfYEDhi/d9uVo7ArvPw/YIaocy1hYg/4G9WctHj+lHbbumH7z9Ff0vNU8u6rDZ5b9li
         HqYyTydbTYD331XhOSqXa/TGbHaduM4++0wCcCnfa3QbgFXxzNCiluxtplXJoXw567vE
         syzC7QGbVEJFJQdn4iGETJw2lZz0tCh5NHE3Lys+qtlMoam5wiT6f4lU7CtEOte+xVZK
         eR3Pv/p79w5NQ73zTgdUrMM2TaFpOBvgTYLuENawVHOsGYrs38ah/3gUMx3LbcjT2HLL
         JA6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSxGYuyN0xsbe1MTaQ0fB/SSS1P80TxcJjikLLxONnh+vQP9nnmyfDpEtVa6w+rIXDSa7z2QQy4dsvug==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzvxM9juKtz2WdTC876396JiGCle4zvijjPSy4wd5lI85yBPZdG
	2HRa0JxdqXkvolVElnW1HmYaiMISKuluLCLzE5X+4kHc0Ack4BC5aATDv/1oPeL5xN0+T34vxgE
	TgO8bvEnsKsKDD/oA7LPujw0VqbzkETE=
X-Gm-Gg: AY/fxX5mA9DHumq/Y3zrxXqjjWw0SHfo1F99Dt3gzy/FGAz8G5DtO5F361J7aFm4KJC
	TSKX7uIeYau8tyQDVDwe5YwfKsC0Y6Ox8WHfVK72kkXt+C5glkWFlC/ihi0msgvUFIuf/AsNctZ
	o64PX/2cVllqn/vabSQxhT2Y1MyzGPwV2lB6/4DoUZl5ShNwH0QWmmKYoX8sylFGavUXZs1KOE6
	TsnIX1YDv1c9gi+99YBMdlbnHRyGFCoe9ag1Z4MUFFS+UNh4peqPhfdT6Kz5Bc8tpYhlPL3J8Y0
	uEr/ksgsmdHb/WiRoIo3xCCh2+B+gA==
X-Received: by 2002:a05:6402:4402:b0:64b:4540:6edb with SMTP id
 4fb4d7f45d1cf-65452ad0f58mr442903a12.22.1768505202965; Thu, 15 Jan 2026
 11:26:42 -0800 (PST)
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
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org> <20260115-exportfs-nfsd-v1-15-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-15-8e80160e3c0c@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 20:26:31 +0100
X-Gm-Features: AZwV_QgHlhd5AJtx9A_oESS7w6U6eCWyUuqrhH3MyU474xj2Kq62KuhGZ4o-aoc
Message-ID: <CAOQ4uxiTE+8r+F-e91cg9wZY-fjZfSHHOeLk3RWb+2JQQZvbvA@mail.gmail.com>
Subject: Re: [PATCH 15/29] smb/client: add EXPORT_OP_STABLE_HANDLES flag to
 export operations
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
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
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, 
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

On Thu, Jan 15, 2026 at 6:49=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add the EXPORT_OP_STABLE_HANDLES flag to cifs export operations to indica=
te
> that this filesystem can be exported via NFS.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/smb/client/export.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/smb/client/export.c b/fs/smb/client/export.c
> index d606e8cbcb7db2b4026675bd9cbc264834687807..c1c23e21bfe610f1b5bf8d0ee=
a64ab49e2c6ee3a 100644
> --- a/fs/smb/client/export.c
> +++ b/fs/smb/client/export.c
> @@ -47,6 +47,7 @@ const struct export_operations cifs_export_ops =3D {
>   * Following export operations are mandatory for NFS export support:
>   *     .fh_to_dentry =3D
>   */
> +       .flags =3D EXPORT_OP_STABLE_HANDLES,

Kind of odd to have this here after the comment out of NFS export.
Maybe add it inside the comment...

Thanks,
Amir.

