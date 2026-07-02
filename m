Return-Path: <linux-erofs+bounces-3802-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6PDtG69gRmq4SAsAu9opvQ
	(envelope-from <linux-erofs+bounces-3802-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Jul 2026 14:59:27 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C816F8071
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Jul 2026 14:59:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JUhLPtBO;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3802-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3802-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=2")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grcQz25v9z2ypm;
	Thu, 02 Jul 2026 22:59:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782997163;
	cv=pass; b=NRjrlW/aMQhH6TYa38WtJzoEwwpBLpFmwQy6KcRPdWzxpzFLOs8J09PkrXdeVvEqDU7ODKkOr8WCFzVIumqNC5ruFsoHk3IamZOnJtK5Hhwu4HTnKe70DRyWp+aaJtZUHZ9ZsHcAnVqdTTQSlUvdfmisMPib83rJ6s2MOu2y76XqZ8K2IZMD56p91o0RhQDcc8CZu6WtBr4VqTWEkP8JuSksv+421fKyv66aILyzofoWuqyGpnpak2zPJQZ6lfX+6n4x0j+1SXMW7BcLNIPo5LR/BgeEixBG0mSh0OIC+RhshYKwbdMHfsDmpyasq/SpnIkm+nqgVTE6A1hZ7zfxpw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782997163; c=relaxed/relaxed;
	bh=rZEnktGYS3FaSvMJHBvWp/Cz6mAa6hG1ZLvsr/GD/no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGihsgK6Zo/1Y3fyfEmcL5skaynUwzyFigl2OBFf2BD9zkVi8zeLwa3J2mv5T6NohXt5hHQIOsG9Xvhng1PQdYcoRLzHRzLKsr+ClN2LtHLD/8hI5i7/3VjPzVaBewJO041aQXKtCMN8bbOhm+8ucKkb639HsgFEWW6QscgsLZiku6xSi4Nv6Z1G1lvxX+x/Wu214LeNARZoVaJ4neLQ95EQX4uqNCu/0CKFkNk7GaM4QQnS6BhGm/eP2mtlKvFwZWMfKmziY955QeMBBrwsC808G0NH/au4wF3RDZfaqkGM0CECLlvlrUqi+ClPEvoleZlJbnIfNaKqyUeUntQIhQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JUhLPtBO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com [IPv6:2607:f8b0:4864:20::b12d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grcQy0zCFz2ypW
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Jul 2026 22:59:21 +1000 (AEST)
Received: by mail-yx1-xb12d.google.com with SMTP id 956f58d0204a3-664c1cf7445so2314897d50.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 02 Jul 2026 05:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782997159; cv=none;
        d=google.com; s=arc-20260327;
        b=WfZuvaBChgmJICwg8NlWRTb3DBCDh6ilA2Skvgp9iE0MEOpMDK8zwFHc/NfYsOO9H3
         lNRyEoB3F4Wf1YJlBRfpCFlx206X1TW2M3w0j4OadkLB2bJZ0TSmEBxuvyGCYQVwkyRP
         WUx/Lmzgc8N9yHDpez2Oa/JY2ohzkug9KFzQOr9HVC0eG7FZfxBIP3XyLGIkM4YUpjhO
         ifvj+PPhc66jLVXI0Xqno64f8eJ7vhAdtOJwjF6rOyyydJQ3EdYYOFnBmbSg9tl65tcQ
         BzM1XzlQUX7PP7veMD68ydhNxSVW68kCLi5EmAptkDl0mi7Imbx4xV32JdBpL9eaU/Kp
         xmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rZEnktGYS3FaSvMJHBvWp/Cz6mAa6hG1ZLvsr/GD/no=;
        fh=LkPzkD36zDjIMdtiFtaEJ+rRd7z8TGwO22EJBZEEqoQ=;
        b=skj78+ABXMKpVQ5squZDpm/u5HhTgPHYr8wAUGid5rBWxP9DZ3DRYJS6A+D/PcveX3
         ZUiA2VBYtUeE2HKuBhPqRGJqwcaGYV9sOw812s+x1au1Fvc+f5VR9FN1WGDbxuadmA3P
         n7FtRAQ6ThJYzA6U0fXcnHZ/cVgy5aDRXQj2MMKdk63+U6APPOmfGZCepsEJqjTmosmL
         xoYiSZLWXBszLzDJSYJ+LWlMhnLvy1ZimOqYpT5C7S6qAMILWVZpfh527flv2ZdBiCJW
         9Tr44Hidprh2pC6ke0Fm3pdJKbIbqmp7eSUKU5tduJM+NWjdVBtMsqi2rbyD3iX1RQ55
         DmYg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782997159; x=1783601959; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rZEnktGYS3FaSvMJHBvWp/Cz6mAa6hG1ZLvsr/GD/no=;
        b=JUhLPtBOH0UgkGyFq5OGQlLtBdMs2ZEjTyfyXSSW55jk6WG8PRha3mYq2yrv4titep
         EXT/1iXfHaNbrAKMOn673HW32es5Y6vwN8EvsLrheTG7ahuTCMlSAAAIhd/C51JPHBZC
         gRutIct7NwnYGwfjbaHpVmDOrX30uH+aGoQzd9vxuRNmUiPxtYrGlMPvZWKvBhAYvEnK
         0aqnqAflx8nHRXAVW36xz4Ga7OgDQ4sMqUJI1ghBysup/CuHyVzL3zhbQvt1lPf6+iBv
         +VAbgjfaRkVu+bfoddCqSJC1DpNuSOvr1kdVF1v2ThdoY83FxBU1oisj2+Km5W42xvqb
         4ZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782997159; x=1783601959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZEnktGYS3FaSvMJHBvWp/Cz6mAa6hG1ZLvsr/GD/no=;
        b=sJ/B53JYR49TTeLpHwOdyQVE15E9utVabQkuPRf+R0qOX4bzHWZ3Ule2QVzzWQUgkD
         qckl3t+tC4Lrx4AECwErcxsR5rRPaXaLjFdf+znYqLaxLVS/uvHyJb+LX+TYuxMLs2Hc
         9LVHeTdEVtqfajLXOUazD8PadhUNH7r2A9goWp8Q6eTrcza8vP0OqQIuGcJ+9R1FbGy8
         cLZlQmdcLJ5jvfdegUrS719cxoUuwZFf5IrQ/lxQMVD7UB8yCi+11IHdL1/8cWuk1V37
         O7d9C8e87ILwT6sldJd4rTOWhNOuiWzh6jzdsWUSouyWHp+mnZNdJfdtNAQu8OiuiRzE
         aQ+Q==
X-Gm-Message-State: AOJu0YyRQfX/NAKkAh/l4L7m2qYJ2kQy/uDQf+JRTG9Ad5HRh1mF950q
	lWQxqvZFFaqsRAV4zlcKHjcRnIsox/El1lD+pHid1K2BYx7sjXnHyW3Cu+kLWRGEttRYJxDGAMv
	UIukOQv7ZzHAz65A4jxSgOLQcy378wc0=
X-Gm-Gg: AfdE7clL3uwQ+X++JelQnsOHYEwC+6cdrw9xmj7eY7el01Ci5GjB3HJ0OBLCCHiH/ot
	Fll6VUohnerTz0j5gQRncanlVCDKbwDEXIA02Lom4NjTD3l+SRia5KChIsmuekQ1JCD3lfg4F71
	j+WbMTaTcREYu+NyYpR/3L8RTebYlBUy699oF7j4TV2zPEcrLTAdKvyt11ELWbL45nogu92Tbnd
	PqKuP/GYsn/nvgU7pIfcx/qgjJ3HVrSLwSkucMpdlik4hu0u7IxFkdOnxhYQvgACy6fUuXxdPW7
	X2c7UviEwoybT4SwFJdQLbERchJ7Mg0=
X-Received: by 2002:a05:690e:4089:b0:665:a15a:71aa with SMTP id
 956f58d0204a3-665a15a74f2mr4921847d50.72.1782997158624; Thu, 02 Jul 2026
 05:59:18 -0700 (PDT)
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
References: <20260702081030.10038-1-nithurshen.dev@gmail.com> <75a94b5a-011a-4b7f-bd98-5b40d756f842@linux.alibaba.com>
In-Reply-To: <75a94b5a-011a-4b7f-bd98-5b40d756f842@linux.alibaba.com>
From: Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Date: Thu, 2 Jul 2026 18:29:04 +0530
X-Gm-Features: AVVi8CcjFkzCauRWKu2N2vIjII7lox-ng5DWzLV8UrGM-1_Yq0VndUPb6S36v14
Message-ID: <CANRYsKjDbs6_FekTRpJeEw124m9D-mQJu-GvvUP2ms8y9uxK=Q@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: fsck: add concurrent extraction and decompression
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, hsiangkao@alibaba.com
Content-Type: multipart/alternative; boundary="0000000000004683860655a060aa"
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:hsiangkao@alibaba.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-3802-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,kernel.org,alibaba.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8C816F8071

--0000000000004683860655a060aa
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Jul, 2026, 18:24 Gao Xiang, <hsiangkao@linux.alibaba.com> wrote:

>
>
> On 2026/7/2 16:10, Nithurshen wrote:
> > This patch introduces a multi-threaded pipeline for fsck.erofs,
> > combining parallel directory traversal with background pcluster
> > decompression to significantly reduce extraction time.
> >
> > Key architectural changes include:
> >
> > - Thread-Safe State: Removes the global dirstack array and
> >    fsckcfg.extract_path. These are replaced with per-task localized
> >    paths and thread-local linked lists to eliminate data races.
> > - Concurrent Traversal: Refactors erofsfsck_dirent_iter to allocate
> >    task structures and dispatch inode processing to a background
> >    workqueue (z_erofs_mt_wq).
> > - Asynchronous Decompression: Introduces z_erofs_mt_read_ctx to
> >    batch pcluster reads and decouple decompression from main I/O.
> >    Limits batch size dynamically (32 for LZ4, 8 for compute-heavy
> >    algorithms) to balance CPU cache hits and memory overhead.
> > - Memory & Deadlock Safety: Implements inline backpressure during
> >    directory iteration. If pending inodes exceed workqueue capacity,
> >    execution falls back to synchronous processing to prevent
> >    recursive thread-pool starvation and unbounded memory growth.
> > - Synchronization Primitives: Adds portable condition variable
> >    wrappers (erofs_cond_t) to ensure the main thread safely waits
> >    for all pending background inodes before exiting.
> >
> > Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
>
> What's the relationship with the previous two patches?
>

I made then into one atomic patch, since you wanted them merged at once.

Thanks,
Nithurshen

Thanks,
> Gao Xiang
>

--0000000000004683860655a060aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 2 Jul, 2026, 18:24 Gao X=
iang, &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com">hsiangkao@linux.al=
ibaba.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
On 2026/7/2 16:10, Nithurshen wrote:<br>
&gt; This patch introduces a multi-threaded pipeline for fsck.erofs,<br>
&gt; combining parallel directory traversal with background pcluster<br>
&gt; decompression to significantly reduce extraction time.<br>
&gt; <br>
&gt; Key architectural changes include:<br>
&gt; <br>
&gt; - Thread-Safe State: Removes the global dirstack array and<br>
&gt;=C2=A0 =C2=A0 fsckcfg.extract_path. These are replaced with per-task lo=
calized<br>
&gt;=C2=A0 =C2=A0 paths and thread-local linked lists to eliminate data rac=
es.<br>
&gt; - Concurrent Traversal: Refactors erofsfsck_dirent_iter to allocate<br=
>
&gt;=C2=A0 =C2=A0 task structures and dispatch inode processing to a backgr=
ound<br>
&gt;=C2=A0 =C2=A0 workqueue (z_erofs_mt_wq).<br>
&gt; - Asynchronous Decompression: Introduces z_erofs_mt_read_ctx to<br>
&gt;=C2=A0 =C2=A0 batch pcluster reads and decouple decompression from main=
 I/O.<br>
&gt;=C2=A0 =C2=A0 Limits batch size dynamically (32 for LZ4, 8 for compute-=
heavy<br>
&gt;=C2=A0 =C2=A0 algorithms) to balance CPU cache hits and memory overhead=
.<br>
&gt; - Memory &amp; Deadlock Safety: Implements inline backpressure during<=
br>
&gt;=C2=A0 =C2=A0 directory iteration. If pending inodes exceed workqueue c=
apacity,<br>
&gt;=C2=A0 =C2=A0 execution falls back to synchronous processing to prevent=
<br>
&gt;=C2=A0 =C2=A0 recursive thread-pool starvation and unbounded memory gro=
wth.<br>
&gt; - Synchronization Primitives: Adds portable condition variable<br>
&gt;=C2=A0 =C2=A0 wrappers (erofs_cond_t) to ensure the main thread safely =
waits<br>
&gt;=C2=A0 =C2=A0 for all pending background inodes before exiting.<br>
&gt; <br>
&gt; Signed-off-by: Nithurshen &lt;<a href=3D"mailto:nithurshen.dev@gmail.c=
om" target=3D"_blank" rel=3D"noreferrer">nithurshen.dev@gmail.com</a>&gt;<b=
r>
<br>
What&#39;s the relationship with the previous two patches?<br></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I made then into =
one atomic patch, since you wanted them merged at once.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Thanks,</div><div dir=3D"auto">Nithurshen</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
 gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Thanks,<br>
Gao Xiang<br>
</blockquote></div></div></div>

--0000000000004683860655a060aa--

