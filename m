Return-Path: <linux-erofs+bounces-1917-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AB80CD27507
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 19:17:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsWS512L7z2yFm;
	Fri, 16 Jan 2026 05:17:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::535" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768501077;
	cv=pass; b=NEp5pKFBnf7aKu9eIc2PhP1XLJmaCH+Y/Lp0oUvQQs16NbSup2baReTl0HLAxCoYy1ZepIuu2Fju+DVtEr9pTmRU8e6LfhcP5WEaZsE+HjX2S4sM9EJuNE8JcFZd2L2bemBFB2aMYgSDMgLqgHyDioN1hywoNskikjm2ksOCvXT7F9UV5POREdSEmWQge0ZLN+58z/bIZ5SNlgP7P8ro6g01s4IIpL/x9hnDJHD9KCsodk0kiN1yZ5ggCVmEeTBU/WYVRvX0dBPEYfJ18vWZx43epZYK0LbPz3bDNY9FUUYJNsb2QPnsUeX37X2AEwoU+foBV9R8cTJPY/WJmzTJNg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768501077; c=relaxed/relaxed;
	bh=lrPbqnzgCOvE5NgsFSOuHcaOEuIUQeGDqGbHFIodw8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9+NUKJOy+NAccqI2fRfaduxWNSw9XyQw9NiiJZex2Ehchc+4NcKkfmaa6FT6ldj2LMWxqJWSBnzZvojWri+dQ58DJArH4TDdZAnYirkD+O6tHScO1nHMNTyW3nUOJGQsHfqBi+MN/6s+EWaBK49zKzk4MCIyJKy7+ZLamb6Q6i6uaoU6VNhg2rIu+jrJnTm7jcVSEHDOZ9q2M6CVb0okwV9BtxyBpiI47Lz/nZA+FHJTKMbxR4w1GOEpQZOpo24vKX9POgphUjUF68R1T0rQ5UwuaJW3zUjf/KYzf79Zf8jbZww03ztBYczlwvLMRR3L/IzepRlWQflG6O2DeoHQA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=k/RF4C/z; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=k/RF4C/z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsWS32S6Gz2xNg
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 05:17:54 +1100 (AEDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-64b5ed53d0aso1716533a12.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 10:17:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768501067; cv=none;
        d=google.com; s=arc-20240605;
        b=bSTCrzIGrKbBMuO88Buxo3eeDGZ9iQX0Ygit5PlM8up1NId2yL7+4/pArYiIxSheKd
         +sOhYDAVt/7fYOnQHWE7pKRHoVeUblUWJbu2XJplSC5hG3NbfNiP+POvgjobn+SSEGYW
         Odnc+WbHfLo3utY62V4RXh3G0VRj67tVvVMVbZ7gDHPZ3TYdFzc4OqKDKwBNHONndEk9
         XoOh4PFwyE4PyRTU0O1pjeyPa6OCtUrFp0TnXPaOphfJ38w74EWjX/H6CQD/8ptTaEF5
         xltt4BEzzocaYBeW9PJTdg79FXmAR/ipvL15iiiA03a3vJcWEB+lhMpTX0M9Y9bMpAY6
         rK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lrPbqnzgCOvE5NgsFSOuHcaOEuIUQeGDqGbHFIodw8A=;
        fh=LoXZRjF5PQgT9vEziMCnUS+pPcXG/gdFkDFubxTrHqs=;
        b=DT4ci/iSLW5mxFPLaOgh9+6v8eQlQ7F8UjUWxCc5xa+8U+y+dpBtSTxxmoihVaQq3s
         TkNxn7NTZWQCAxEvycJqthB0uJKSTg4Iow7SrI0pT4avCm8TgQXZVycTYzkMZYAYW2Ce
         4QyTirOLVqT04/fSG8Xmpro7FKpx8F8W7iXJNppr1yCaxI61mqcx/prwp1sbnzJT5fA9
         WRL5YKQYok9/mofT1sJl2XlTT+muU4tBgTd5pwdCkBQWNu+dGXYAmkCmeMoMCTCefggs
         PsFOMCImztat+r0d9/uP/34nfkt6Vh0zcyQWWzBWTkG9aSvQBgHyfMhIdZWRij/a+yCT
         YirA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768501067; x=1769105867; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrPbqnzgCOvE5NgsFSOuHcaOEuIUQeGDqGbHFIodw8A=;
        b=k/RF4C/zBSeekuLqqXKgy53O3+pzSMuNKVVLbN4qovAhMwxVTAAq3hsgyICx8YrCBn
         qUHmIGO9kanHmHiw3ju+18aV86WUAdPtP4I8PA3Bulj2ODt6xDL2HdLvfgSDDLyWF7BS
         wmu0IskuPrURkm9nXLBlodwN2BXlomZnOxMuiozskpirpvffeJGWlv8uFvHWpudLN4ro
         zv4y6+1jC0qaX1PsESTEz497QtjVV3muPnDJZMRDhk3NGSP1/nvmSswx7oFj/MQUkddN
         BR+5D14nsGMghJLh2Jh4RkYWAmFiQiQdQ4hQ+rkz41vq3mpHOPyiED2br+7piiREEE+P
         Qfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501067; x=1769105867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lrPbqnzgCOvE5NgsFSOuHcaOEuIUQeGDqGbHFIodw8A=;
        b=AYzkwQqljcb5xEuHVM1156iH98tveBGv0nR1EiGjXsKSBFGC2fbYX13221bG4iRJlM
         wMpBJKtSxl6vGO4dm9NRJ1s2I+zuDeaXz6nKkD7yKRn5VErSshxXGijgc5JXNQA8a74z
         kLxIwMr2DTk3pF31ZmRcEi7+A1Yf423h5/Rm3HFlaggmWrnI6t7I+qiAskcwvX/EEa/z
         ukKMAexXsn22OOa9a7huX5V0ZaieI8ydKqamuqdgxpctbQYUXV4CLrQVAq4pK+O2JNO8
         BG9AwWeQgEZ0+DcBPjmSEyIAcoALOoI9QhnCQCDsTWk7P8O0y8qc2TlCkwpfgSgFPhV/
         ektg==
X-Forwarded-Encrypted: i=1; AJvYcCXClpeb2wcceFFumy2FcxK3nxiNEnI4WJLC/jJAdspVnUDPFK6VyTFMPFCn19dAQwiIaPb57ecvsd3pEA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzsvAXpJg7X6594A+YxmzBeGVBbdKS7LOx0l16TUCckMAy6k6SC
	2LhkpqO9MZYwiwmZQSXriLENt1/Csp/EhTOMchVF2+/8s0Ni97Q5ehQkLoMHczPA59q1lPwiXEs
	gBkmDIULR7d9fsVY5+oRuJckVpJTkXlg=
X-Gm-Gg: AY/fxX7HOGCl0W558qn5ENlEH3vVDsoqQiH4JhjTTw6RrRtnnRJDlzRYl9/o3J6fv6m
	HI8HesZ83v92Oo4agFnkO2fmUGhi/OAPQueAP+Y9Bfe67UqOeoFAg70eCq2qMpXpItFX81gdmym
	2gX3uV585yqga8xqM/u7B68CATLZzKLOlBC0W2K+J7zsOus+5zeGZi8f+VDklTYXeXjlCXyf4qS
	NPEFwZSD26ZoScJQQC588fy0fnKNWfP61oBYGEy38fNy+y+deZRZ2sN7WsJcGaPYtU0WYFVxYt9
	E0Ai8TvetV08RoaT2z3Bzgjf2ybxRw==
X-Received: by 2002:a05:6402:510f:b0:64b:7eba:39ed with SMTP id
 4fb4d7f45d1cf-654525ccad4mr346097a12.13.1768501066374; Thu, 15 Jan 2026
 10:17:46 -0800 (PST)
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
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 19:17:35 +0100
X-Gm-Features: AZwV_QjhT3ZtgvkbHJB7796GEklGCbcNDL5CeRwrn_YYeN3X8FqPO-3_iRnRORw
Message-ID: <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, Jan 15, 2026 at 6:48=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> In recent years, a number of filesystems that can't present stable
> filehandles have grown struct export_operations. They've mostly done
> this for local use-cases (enabling open_by_handle_at() and the like).
> Unfortunately, having export_operations is generally sufficient to make
> a filesystem be considered exportable via nfsd, but that requires that
> the server present stable filehandles.

Where does the term "stable file handles" come from? and what does it mean?
Why not "persistent handles", which is described in NFS and SMB specs?

Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
by both Christoph and Christian:

https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-12018e93c0=
0c@brauner/

Am I missing anything?

Thanks,
Amir.

