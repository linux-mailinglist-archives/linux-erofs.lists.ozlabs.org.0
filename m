Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A089967CC8
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 01:41:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WxpLd4Rl5z2yJ9
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 09:41:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::22c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725234086;
	cv=none; b=BPFdd7moH1yg7ehVWoV7jB9GyAM4Q7DWmhNLXEgr0pnxorfZgB0n4qSR+pzs1DW+92Gf7ckIW+dI+Vcv/9+xs5DLOxpTCP6943kTLBtitGZdr416/oL5CAmRNs8vepyJzqXhb7Q+FyzGqakJNxqmAZLZJz88Eq1Q2IZ6nPdO6NgAQNX4sHV7+m9W6a/YcHqBdGqDJVdE2Rh+NAMVWq2/3WE1e5ruHvZY779dNByfrm/4W2vU4IEhRjrh6ikuM8+e2SSno5iLtchkBkB50M1FHe04j0sNSF/l4a0NioGt7aNd0zys9yzB1yqr84MtboYs8p4dbXjwKnxS81qGFOFo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725234086; c=relaxed/relaxed;
	bh=0OptCrhRONfMIpYiriIyIArvvwMoZ9X5KBzqF2jB2C8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Google-Smtp-Source:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	b=dkmUz4gxtEV6DQ6BFLS1ffAcZgTbhSpGNcJwtoGUp0o6hfqhhoF6/szwjmYORbCvpzj6hlw8sEryVSiDYhsBqsUPatT0NAhyVJ7q6ErpCFLKadvv6bXVq4i7ghhvXpG2tJcD6S4GKUjSedBDsW442a3E0uZaMwqtbWFq3Aim38u2ZZ3+mOpYyhImo992AwuXjBRNElFAdyO6QDy3K6hm/U9Q0IUd1da6yaHYu6Nxt34n8KVF2bVUC4jpbG3DDGYuBSoyvaHA4huU5WybAzO0SAGW6gvmTDDnQCIvGzi7kbeREzLlbhegX/oX+UQctsfdl5L65wro5ujAmXjG1R8ZEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EPSGFdSv; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::22c; helo=mail-lj1-x22c.google.com; envelope-from=smfrench@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EPSGFdSv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::22c; helo=mail-lj1-x22c.google.com; envelope-from=smfrench@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WxpLY1fjkz2xT8
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 09:41:24 +1000 (AEST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2f4f8742138so39787531fa.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 01 Sep 2024 16:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725234077; x=1725838877; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OptCrhRONfMIpYiriIyIArvvwMoZ9X5KBzqF2jB2C8=;
        b=EPSGFdSvoZLAehaxlyETZc5W1Uj60wE5MrCa4rr+q/6HiWJ9sbQk9pcuA9X6oyOQfl
         kDXyvnedc/p/XTgguDTu0g9X3KIFVRUT2B85P1c7KOIamiy/zcOnz/wBuKxvASj4L98T
         u3NFVYZUMQGuaUdFepejzxUVd0Ya+2bdxkM+1HSWtyGweoAvFsqMx0qtOYH2UB7ZyFrI
         uu1jJrW9sQWREnQmFEBimZSfZSMa7GMJrTd+pKjRb2xqMkp4B1UqDz9KUjw4NHyTmA+N
         tBAwOHcEukpc5FEfdgOZ9XpByzL/JGkOewhZNrjPWCw5w+Tu8rYuoJkDbLkaYAQLdYH+
         TTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725234077; x=1725838877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OptCrhRONfMIpYiriIyIArvvwMoZ9X5KBzqF2jB2C8=;
        b=IwNjmV3rE3KBJQXzCWMg06RlED5/KPXLcC41FeO8UyBe7hhhRgvDMkmDSi9+lennDr
         ccujPOPzolDtVT2kSDoJBrdC8ftRN117asdBzsK1HsfV54nqqAfmEKW2+Cq6GYxbrXHj
         oJvNHyal33xOUPzRdCs2rxI51Q+SExWsd2BXTYl6HaG9ISgGYqP6iU+SdAeureFKSqKK
         fVTBq0OI9xSdN8xCuB1G31X9frxWgjxySBAJsPWJSscPUGLw18to4P4xV7tizZRKAXz7
         2MP3DOb8j/TcH7UtkmaR1Q/bXLUQcizjL7AOpm5Lfjz29Ez6daI8yF3gO4zsf7OB9UWl
         +3sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJSYck59Q2E3QZTqpteDv6e2u0SvLlJh2lBXdTp5ss9Yjm/3l1AsKSV+eGQD3XzjTS+aaFMWglClJ6UQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyJ0ibAAJS+uRCjNEMmn6JpSDu5kGAmvtkHOLUuaWkRFf2JSej2
	6ajppkbxeQMebNbpP6qx+tbOoYFMWhAoE+VRdeYEG8obCcciEg0wzdQyiuIlqGgIgbpYPirRb0S
	WxkcEu/TIs1qhUSlVVwMPoHQm4Xg=
X-Google-Smtp-Source: AGHT+IHrpw2kTpvaZiyKJAHMxmQ/fhZpxqRdKI1vFWTY9ydD57nABAkwYo+y3SH1kUAvMU7Md95wbwacKxJ+67IyRxg=
X-Received: by 2002:a2e:be29:0:b0:2f5:23a:106b with SMTP id
 38308e7fff4ca-2f610890868mr90286721fa.34.1725234076595; Sun, 01 Sep 2024
 16:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240828210249.1078637-1-dhowells@redhat.com> <20240828210249.1078637-5-dhowells@redhat.com>
 <20240830-anteil-haarfarbe-d11935ac1017@brauner>
In-Reply-To: <20240830-anteil-haarfarbe-d11935ac1017@brauner>
From: Steve French <smfrench@gmail.com>
Date: Sun, 1 Sep 2024 18:41:05 -0500
Message-ID: <CAH2r5mv8merj9J=UK-U2xsSArL2s9zuRP-bZHnM39jU6Ujx9JQ@mail.gmail.com>
Subject: Re: (subset) [PATCH 4/6] mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
To: Christian Brauner <brauner@kernel.org>
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Matthew Wilcox <willy@infradead.org>, linux-afs@lists.infradead.org, devel@lists.orangefs.org, Tom Talpey <tom@talpey.com>, Alexander Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This looks like an important one as it fixes multiple xfstests see e.g.
with the patch:
http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/3/=
builds/213
vs without
http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/3/=
builds/212

Can add:
Tested--by: Steve French <stfrench@microsoft.com>

On Fri, Aug 30, 2024 at 8:12=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, 28 Aug 2024 22:02:45 +0100, David Howells wrote:
> > Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
> > rather than truncate_inode_pages_range().  The latter clears the
> > invalidated bit of a partial pages rather than discarding it entirely.
> > This causes copy_file_range() to fail on cifs because the partial pages=
 at
> > either end of the destination range aren't evicted and reread, but rath=
er
> > just partly cleared.
> >
> > [...]
>
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
>
> [4/6] mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_r=
ange()
>       https://git.kernel.org/vfs/vfs/c/c26096ee0278
>


--=20
Thanks,

Steve
