Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B0E8A5DDE
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 00:51:57 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bBs9/Wfo;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJMqX6bhsz3cgg
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 08:51:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bBs9/Wfo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::12a; helo=mail-lf1-x12a.google.com; envelope-from=smfrench@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VJMqS2SGkz3c9y
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Apr 2024 08:51:46 +1000 (AEST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-516d0162fa1so4728197e87.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 15 Apr 2024 15:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713221500; x=1713826300; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63WuSgSRy34JNOa9pVcP0sGLwbzNT5xJkZeCbwGkCUE=;
        b=bBs9/Wfo15FO90ODSB86St/1Y95KRyzHKVZ7CIxube5+RpHzs10ylbZIQ/bU/5tq8w
         dHPCNFFP46RjktQUVtUAPn2Al0t9SijfHmEYHtGrmRWjMPqpEpsZItTJ4+nZNbSKPP/d
         gt+20VrNqKQE8CJsUF/2uESEJDS0jilDPAMPvTt7iVqy1fRV0f+9slN2sW5FFlZvpEQb
         plDH3AiOrGPIJvemfPf2lSiLgyFVd7Nft2nyQMH0sNAuOfTt5nqFDkBM0a/6DFTPHlne
         DwFsspMnqogZIs96ArpmKg4rFbRzWu9di6LS9c73+bJ/1FaEKYoH8ePiHyPhz8XDCGiO
         tlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713221500; x=1713826300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63WuSgSRy34JNOa9pVcP0sGLwbzNT5xJkZeCbwGkCUE=;
        b=DqN/vegmYRX5IPsxHvwvWB6E87jRKsoAkOYsaV8J3b69/ZHdfugTEJn3e/dFGJVK0Q
         7ldzb2VQZEleNOxtdvJEGRk6RaUrS/rEPD7pNUuEBJc3Xydc904aBf65TUrUaDMBHWfB
         YdPXSDQo+k2zwCU2ovtyTqs+wA/KEGYH8VVn/+RDllrXWP5JCCFzJnEvmmMpcHEq9Yfp
         xsirDH1BUMkf3QRdDfNFGL0AWOZofSYURcawoBjwL5E7grpho2UmbmAQPvxjPVbIH6T3
         12LHp50xB1NeRHI0y2zHY3gLFkpzxQcfxvTQb884xt0LOcnJR3bpE9DW5scLaI3iXdPm
         1pMw==
X-Forwarded-Encrypted: i=1; AJvYcCU8WKmaI2LBgy9JLSwrgY+1KXadsKj50hzg1cxBOs1vHmdh2g5c6kheD4OntgdRyIZnKHJ9tNSY7lrng+rl9GzR+J52MPm8LB9FYum6
X-Gm-Message-State: AOJu0YysizhJ3ObNgUYujOqdXYHYB69us4GhfgRip8NCwkHk9TI/Ytzp
	IdoaM5QBHXRE7Mt0cah3uPx6mXzu29Agq+0QqyuUSfvA+peeBzAoA5JpEQxlfa623WLVC9UVDMh
	ABW8dJ58lClahdbG0xHZib3ls5M4=
X-Google-Smtp-Source: AGHT+IF8RFFMQuN5vGtuRwBPhuh0oAZccy2g38TQjUdEv5QNHmaH/Tohq78D8IN9/9jH1PsE9dc35dj2/YRmRw43rn8=
X-Received: by 2002:a19:5f1e:0:b0:516:b07a:5b62 with SMTP id
 t30-20020a195f1e000000b00516b07a5b62mr8309996lfb.54.1713221500147; Mon, 15
 Apr 2024 15:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-2-dhowells@redhat.com>
 <39de1e2ac2ae6a535e23faccd304d7c5459054a2.camel@kernel.org> <2345944.1713186234@warthog.procyon.org.uk>
In-Reply-To: <2345944.1713186234@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Mon, 15 Apr 2024 17:51:30 -0500
Message-ID: <CAH2r5msFoGAE79pS5bEt5T8a60LU82mdjNdpfe0bG4YpvY8t-g@mail.gmail.com>
Subject: Re: [PATCH 01/26] cifs: Fix duplicate fscache cookie warnings
To: David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <nspmangalore@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Should this be merged independently (and sooner? in rc5?)

On Mon, Apr 15, 2024 at 8:04=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Jeff Layton <jlayton@kernel.org> wrote:
>
> > > +struct cifs_fscache_inode_key {
> > > +
> > > +   __le64  uniqueid;       /* server inode number */
> > > +   __le64  createtime;     /* creation time on server */
> > > +   u8      type;           /* S_IFMT file type */
> > > +} __packed;
> > > +
> >
> > Interesting. So the uniqueid of the inode is not unique within the fs?
> > Or are the clients are mounting shares that span multiple filesystems?
> > Or, are we looking at a situation where the uniqueid is being quickly
> > reused for new inodes after the original inode is unlinked?
>
> The problem is that it's not unique over time.  creat(); unlink(); creat(=
);
> may yield a repeat of the uniqueid.  It's like i_ino in that respect.
>
> David
>


--=20
Thanks,

Steve
