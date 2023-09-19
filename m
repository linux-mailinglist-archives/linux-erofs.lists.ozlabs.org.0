Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D1A7A6765
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Sep 2023 16:56:56 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=clisp.org header.i=@clisp.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=fF6//tlG;
	dkim=fail reason="signature verification failed" header.d=clisp.org header.i=@clisp.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=6cNjscvM;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rql9x58qwz3bd6
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 00:56:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=clisp.org header.i=@clisp.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=fF6//tlG;
	dkim=pass header.d=clisp.org header.i=@clisp.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=6cNjscvM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p03-ob.smtp.rzone.de (client-ip=81.169.146.173; helo=mo4-p03-ob.smtp.rzone.de; envelope-from=bruno@clisp.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 200 seconds by postgrey-1.37 at boromir; Wed, 20 Sep 2023 00:56:44 AEST
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rql9m5wmnz3bT3
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Sep 2023 00:56:44 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1695135168; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iOvNoGriAVw4BG/07a1J6uIof3CWb+6UsSmEBYX+mFyDD9f2QO4Sb9TEKH4ddRJIDy
    pL+qoqUJA0hBoE4nJJQRUmYRrrCYvLF6ta+aYD7VbDg0ud+mbgJHzWwSRqXYR5ZREvcs
    bl3KKbXR7cnsa+lCIA964mIiyg1OT/LsO/TF2FrHwu1Ap2D5rIzbspE4N+uifzZgFcIK
    COMHkjp45ZLpdYvm1mHL/fgF/qpLr3Ss8m6HAe7Z0ayLnnzziqQ/Ve8M0mIoGjiKEXXY
    DzKttOOMKEMKTf6HNofA3SeC0Zyw1CwjchqneHb1ZprMNvSTC6ly89m2hqISShU8ipWO
    EoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695135168;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Hu6LWTHD7s/0PwwSBsDsZf9tkhzretwdfBCU6cYVdik=;
    b=jLy0h5BgGkHaTuA6saeMjLcT80O5PDMj8jn0r6tSDDpygqUl+dbmUNK2KZLi3xz36v
    g0+h6MTV2CZKqKfHLAeBYtTJJfvMQrteqrXMAf+YEKI8sPuGyydwMrWtQLIaLuExR1iT
    ivinSDlU9SKzh7cBAAZFAkm4tFYdkD+gAIJ/khpzKYjHS8eYquYbVcwEhmMPjRUSjsJ/
    Xyda/51K4Z+JTv/CxPginA4cOQbB24NRa8A0ACkAg1iZdOLa3LuXWw69p/BQlbcrdUmk
    nDOjL6QI487/iHR7CcqqZHUX3CmeaRWIDTDq0lKjlF6JLf9u9E5GwBe5L4elNs6OFPWg
    /tRQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695135168;
    s=strato-dkim-0002; d=clisp.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Hu6LWTHD7s/0PwwSBsDsZf9tkhzretwdfBCU6cYVdik=;
    b=fF6//tlGfuaCILPTjW2UXofB8L0JRFiT0ta9GyxmLu/FCo/hW37Kx4K05nm1mWYfZd
    LVW6K8LTlLgwmAHdMNxTGjWLvM3CbMfnEWs6XpLmGxN35UXtfOopJrDhxPXSoAv1kAxk
    txGd6del5ZFz9i7f7QmOOLqULJAgk04E9Inurihh9CTKZ9nagVqkvJz+ZGC16HPzXO5N
    KF+SLwTHn+5drhMusrxLnm/2lhWMaPiVmqnEAm59XcYvwyI3nPVqmk8IusuR43iOH+6V
    azBsyi4ii6sFUL9a23eRkIBKS8HR3R5rirmTCU7G2fe+DZ6pQ7h6YLvKUiFekj0YaORo
    pC6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695135168;
    s=strato-dkim-0003; d=clisp.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Hu6LWTHD7s/0PwwSBsDsZf9tkhzretwdfBCU6cYVdik=;
    b=6cNjscvMV8QarA/cY83EMrQy954wQIS4PLL+CFn8BrFaSsprhsBVWfpxU4X6tTSJkc
    jxMNKxkGefZPdprJTABg==
X-RZG-AUTH: ":Ln4Re0+Ic/6oZXR1YgKryK8brlshOcZlIWs+iCP5vnk6shH0WWb0LN8XZoH94zq68+3cfpPCifIiwFsCkzyDtyDTaOz6CkM="
Received: from nimes.localnet
    by smtp.strato.de (RZmta 49.8.2 AUTH)
    with ESMTPSA id m03934z8JEqhhDO
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 19 Sep 2023 16:52:43 +0200 (CEST)
From: Bruno Haible <bruno@clisp.org>
To: Jan Kara <jack@suse.cz>, Xi Ruoyao <xry111@linuxfromscratch.org>, bug-gnulib@gnu.org
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
Date: Tue, 19 Sep 2023 16:52:43 +0200
Message-ID: <4511209.uG2h0Jr0uP@nimes>
In-Reply-To: <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org> <20230919110457.7fnmzo4nqsi43yqq@quack3> <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, bug-gnulib@gnu.org, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Benjamin Coddington <b
 codding@redhat.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Shyam Prasad N <sprasad@microsoft.com>, Amir Goldstein <amir73il@gmail.com>, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.co
 m>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jeff Layton wrote:
> I'm not sure what we can do for this test. The nap() function is making
> an assumption that the timestamp granularity will be constant, and that
> isn't necessarily the case now.

This is only of secondary importance, because the scenario by Jan Kara
shows a much more fundamental breakage:

> > The ultimate problem is that a sequence like:
> > 
> > write(f1)
> > stat(f2)
> > write(f2)
> > stat(f2)
> > write(f1)
> > stat(f1)
> >
> > can result in f1 timestamp to be (slightly) lower than the final f2
> > timestamp because the second write to f1 didn't bother updating the
> > timestamp. That can indeed be a bit confusing to programs if they compare
> > timestamps between two files. Jeff?
> > 
> 
> Basically yes.

f1 was last written to *after* f2 was last written to. If the timestamp of f1
is then lower than the timestamp of f2, timestamps are fundamentally broken.

Many things in user-space depend on timestamps, such as build system
centered around 'make', but also 'find ... -newer ...'.

Bruno



