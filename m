Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DF75C983A71
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 01:38:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XCKDf42K8z2yS0
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 09:38:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727134688;
	cv=none; b=TNiCe8+vQNPq8lSJTGVengO1+ArfOC23j3T1AEigbOhXsKK+YUQcCCpGrbOFMClqcEx8RIr2aEnNQ5xlEM7vtMY9LSy10GsoW5kwciaobQ9ax4G4j7xkG4Px3wdNJhSB9qld6GSTHqtSWSPAN/in/MEzoiKIxxt4G6RzsWexozDqaNslmxBj4o4sev4/IkG5ahB9uJ7u42ckTYAkHJki06vCgMuYBomD02JFFegBK0CGLxa7yPVmYLiL84l3DhYcxtTE4HPnQtCZB8hcPkLGNDIMPYXmaMiV0dJGDawqWwPPR5L+9PTIZEmcVGaDkvsmiervNJpFygQrJ6xPGzB1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727134688; c=relaxed/relaxed;
	bh=rJ7sS1msjw1V7YsuQ34rxHY/7ajzA+pa1mgHv6cKuhk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VfYvCMOHy3a1XYvTh7u6tRkA9ua9IOYb+XBbfXQZtL/APzLR2cNr2DgtCYwdaSozAShhKgUAKDvfTA50VNKdE0vYe86N2ddGbD15A5dSABlLdjtc+Kvy5bh5TbOS2DPwUS4Wfld4q5odVegw9y3ruqxX4QZa9aQ+BhMyMreDUMdQxjRYW2Uop1EsAojybXkYkbe37NpORrR4MRORsSEqz7BPCwWKdd1JT4ZfREGexqb1RVWr1OSpuaJ3LOl30jTKU/NuWO+kqDOnjH1NKfIQVVQgYitl0S5IUwGM9LZr16EWasUeUmOus34WNYNvyYDg0VbNayWaqCx28MDPvcZVlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TYIdoDqB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=eddyz87@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TYIdoDqB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=eddyz87@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XCKDb51GZz2xm5
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 09:38:06 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso3498154b3a.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 23 Sep 2024 16:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727134684; x=1727739484; darn=lists.ozlabs.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ7sS1msjw1V7YsuQ34rxHY/7ajzA+pa1mgHv6cKuhk=;
        b=TYIdoDqBxk/ap7jwf9szL2trsOLhYdgHciOlv3QBtR38p2jDuQucaOrh3q8cRx50Lk
         UNs+4dbiOAa6niMqJA93F6XMEceGZ3hN0RmZ2Bj5cJtxCN0wlM7dS7EVkvT8I5aqbNhA
         sT0IkGLbIUgUBtp2JR+SRes6IxlJGddvUOYFvvbAWlRENNmC/4c7Hq+hQ/jX3wUYBPh9
         iCohj8xpzRoh+z48kGR0ymlEAH4ORSqtU0/7MRzaZ6NLrkIuvv4yL7hwF2pembmyTjIc
         T11WBJnC+2NYHF0Y6fc+3611EwDEB+AtXacNXQEOlK1HFjqkdbeiJiZhVNJPkiSi9L/j
         3GmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727134684; x=1727739484;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJ7sS1msjw1V7YsuQ34rxHY/7ajzA+pa1mgHv6cKuhk=;
        b=JnYWol3FameCkPOiv3PU3PYiHDWxqn9ePXM22EKs9entnwQUy5GvSyV6zo/p4SZgx8
         k/fPMYsPEXpyGBql9Z+tzf+RZTTyqZrvoJONveL0PMgMtbqjd79Z7VPJYMqOU9ZiRz5Q
         0uHkNuBRa2g9OK+7nLRXS+55uoa8P2cH8fUnEsY8npUagyctK2srrTHYR0U6+mepHQa5
         m9cDD8dfgMR8dJmK55zOnUD1y5zsfF8RHPch/lOcibqu3kt6WgeidVtarwaaUt/GPLr1
         xYQURan3lkSZV1QTvqoWqMeCb0PxpBNqmBo1RsXCBOgLV/E4UohDOqLpJ6VBZd+HH2bs
         5/aA==
X-Forwarded-Encrypted: i=1; AJvYcCW4X35FSZaRs+xR//EDzKi0ivX9ekmlZHxaMhDOWgFcyVp7BlOS2/8Mv+FPqcN8KtumcqtE/J7lENqYXQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxnK/xdlh541y+PGFg01N9Pkp2gxkeLdWjZjfsE49e2RFcI3lWY
	KyHqrV0blPxrd+0Vqu1HY8+xodm5hIUzBXCgrDfX1rpeCF0COVXf
X-Google-Smtp-Source: AGHT+IEn7xNlzig8H3Enwhf26kXdACpLuW4DsQZFPPEgmwNxWuFNyz/yjUDuPQMBz7MUGiacjBcrwg==
X-Received: by 2002:a05:6a00:99f:b0:718:d5e5:2661 with SMTP id d2e1a72fcca58-7199c840a84mr21575147b3a.0.1727134684098;
        Mon, 23 Sep 2024 16:38:04 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9390e9sm144198b3a.124.2024.09.23.16.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 16:38:03 -0700 (PDT)
Message-ID: <ad831566b2e5d44c59ba2526176d9ca75c6ce94d.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Howells <dhowells@redhat.com>
Date: Mon, 23 Sep 2024 16:37:58 -0700
In-Reply-To: <961634.1727130830@warthog.procyon.org.uk>
References: <0f6afef57196cb308aa90be5b06a64793aa24682.camel@gmail.com>
	 <20240814203850.2240469-20-dhowells@redhat.com>
	 <20240923183432.1876750-1-chantr4@gmail.com>
	 <670794146059f85a30efd7cf9d6650375d987077.camel@gmail.com>
	 <961634.1727130830@warthog.procyon.org.uk>
Content-Type: multipart/alternative; boundary="=-Q91RsiEvrT2A6vPIbGYO"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
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
Cc: asmadeus@codewreck.org, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, Manu Bretelle <chantr4@gmail.com>, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--=-Q91RsiEvrT2A6vPIbGYO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-09-23 at 23:33 +0100, David Howells wrote:
> Eduard Zingerman <eddyz87@gmail.com> wrote:
>=20
> > - null-ptr-deref is triggered by access to page->pcp_list.next
> >   when list_del() is called from page_alloc.c:__rmqueue_pcplist(),
>=20
> Can you tell me what the upstream commit ID of your kernel is?  (before a=
ny
> patches are stacked on it)

I used bpf-next tree, but could be reproduced with [1] as well,
commit ID [2]. Decoded dmesg for this commit ID in [3].

[1] git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
[2] abf2050f51fd ("Merge tag 'media/v6.12-1' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/mchehab/linux-media")
[3] https://gist.github.com/eddyz87/af39e04069c6ca30e66c3032c0384b8e

> If you can modify your kernel, can you find the following in fs/netfs/:
>=20
> buffered_read.c:127:			new =3D kmalloc(sizeof(*new), GFP_NOFS);
> buffered_read.c:353:	folioq =3D kmalloc(sizeof(*folioq), GFP_KERNEL);
> buffered_read.c:458:	folioq =3D kmalloc(sizeof(*folioq), GFP_KERNEL);
> misc.c:25:		tail =3D kmalloc(sizeof(*tail), GFP_NOFS);
>=20
> and change the kmalloc to kzalloc?

No changes in behaviour.


--=-Q91RsiEvrT2A6vPIbGYO
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html lang=3D"en" data-color-mode=3D"auto" data-light-theme=3D"light" data-=
dark-theme=3D"dark" data-a11y-animated-images=3D"system" data-a11y-link-und=
erlines=3D"true"><head><style>pre,code,address {
  margin: 0px;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}
blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}
</style></head><body style=3D"overflow-wrap: break-word; -webkit-nbsp-mode:=
 space; line-break: after-white-space;"><pre>On Mon, 2024-09-23 at 23:33 +0=
100, David Howells wrote:</pre><pre>&gt; Eduard Zingerman &lt;eddyz87@gmail=
.com&gt; wrote:</pre><pre>&gt; </pre><pre>&gt; &gt; - null-ptr-deref is tri=
ggered by access to page-&gt;pcp_list.next</pre><pre>&gt; &gt;   when list_=
del() is called from page_alloc.c:__rmqueue_pcplist(),</pre><pre>&gt; </pre=
><pre>&gt; Can you tell me what the upstream commit ID of your kernel is?  =
(before any</pre><pre>&gt; patches are stacked on it)</pre><pre><br></pre><=
pre>I used bpf-next tree, but could be reproduced with [1] as well,</pre><p=
re>commit ID [2]. Decoded dmesg for this commit ID in [3].</pre><pre><br></=
pre><pre>[1] git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it</pre><pre>[2] abf2050f51fd ("Merge tag 'media/v6.12-1' of git://git.kern=
el.org/pub/scm/linux/kernel/git/mchehab/linux-media")</pre><pre>[3] https:/=
/gist.github.com/eddyz87/af39e04069c6ca30e66c3032c0384b8e</pre><pre><br></p=
re><pre>&gt; If you can modify your kernel, can you find the following in f=
s/netfs/:</pre><pre>&gt; </pre><pre>&gt; buffered_read.c:127:			new =3D kma=
lloc(sizeof(*new), GFP_NOFS);</pre><pre>&gt; buffered_read.c:353:	folioq =
=3D kmalloc(sizeof(*folioq), GFP_KERNEL);</pre><pre>&gt; buffered_read.c:45=
8:	folioq =3D kmalloc(sizeof(*folioq), GFP_KERNEL);</pre><pre>&gt; misc.c:2=
5:		tail =3D kmalloc(sizeof(*tail), GFP_NOFS);</pre><pre>&gt; </pre><pre>&g=
t; and change the kmalloc to kzalloc?</pre><pre><br></pre><pre>No changes i=
n behaviour.</pre><pre><br></pre></body></html>

--=-Q91RsiEvrT2A6vPIbGYO--
