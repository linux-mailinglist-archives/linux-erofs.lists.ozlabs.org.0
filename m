Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E22E56BAE9
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Jul 2022 15:35:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LfZ5d0nggz3c4k
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Jul 2022 23:35:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=YgyDGTd7;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=duguoweisz@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=YgyDGTd7;
	dkim-atps=neutral
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LfZ5Z2Zz5z3c1y
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Jul 2022 23:34:56 +1000 (AEST)
Received: by mail-ej1-x633.google.com with SMTP id u12so37714626eja.8
        for <linux-erofs@lists.ozlabs.org>; Fri, 08 Jul 2022 06:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FETep9Ek9gSiul8WKfcdviH+3UDvrrt6pdD1gpIrAc=;
        b=YgyDGTd7xjbiXv1wiZxzNSF6gv2w3B/kLv4Z0helVPUR/S6wK4wCFhcXw4FudJ627i
         4iCvMvkKLHqiRMPRVcpNY0+nyCaVH2nN2eMB16loNKFHOYreD+0bkhMqZoJJ9Qsud5qd
         3SS+RrnzOXlgSFDyQJPw3Resq8kWcfSnNwutraXuKk9BpjVerY5Oyjnnu0vM2ZkIRNPM
         75qhNgarRvKlIqchLun/2U547GnjvPfo2uUDyugEjY+edsFmv/CNIrecKmpiqYhr5VK3
         AI0wG98zg0y+EjWiLNYIsTZT8z3YSdz/ZlZcsoapZircyiZ9y5cBZokmmkKKnMq+BDHC
         eatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FETep9Ek9gSiul8WKfcdviH+3UDvrrt6pdD1gpIrAc=;
        b=bDb6dJWnG4FcOwdC5GXaGAW0TXHfP+elHIMS7akYt2DIYC1xI1JNjz5b6z1rNyjCqo
         dWwjOOAIphW/6c/xQ3divBh4hwIUPcGuSDsXcpdbLAQP3GkXWVRbKEaWglWRQxSSGsgn
         aGpG7fYULBnXri2C+VYaPzzFgK4Fcwe1ZjJVaHMcTk7QoycQM15ZHk3XfGRIR3oQSujg
         tB86dbJfPMfZZxjq8vNjp2MsRHltt+qEhe7w8bw5145SSPGwuqZ6B14A3qe1YCf7vuVf
         e9X3/9XiVeBfpl9G2+uHSt/P5/dWAo2CDUnBPhXLCRY8C25+PZc0sMp1AwYOSMQAzZms
         z3OA==
X-Gm-Message-State: AJIora/cYpPJuVeM8mKEC20uyzfzvJZYuMhrqA43dXLSD2/A0+Q+CieS
	uEj5EcJu9TsqVdnT4NUbgEXIbfb00omhLBJFWjQ=
X-Google-Smtp-Source: AGRyM1tQiW6X/36irQZ4K4HFTGCbKrfeZFc5mhj5cjun8A3IGHnQ+WBrPkqBClvjR+NEJ6CUy9EDbSLUGgKm+pkTevc=
X-Received: by 2002:a17:907:7202:b0:722:e4d6:2e17 with SMTP id
 dr2-20020a170907720200b00722e4d62e17mr3660455ejc.434.1657287289238; Fri, 08
 Jul 2022 06:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220708031155.21878-1-duguoweisz@gmail.com> <YsejnaY7cy3SeHBF@B-P7TQMD6M-0146.local>
 <CAC+1NxvifeHmrerWUqhC-gCUk11vudLVc=o=Hnr5EwYJv+N0ZA@mail.gmail.com> <YsfDm5q9wIyewtWR@B-P7TQMD6M-0146.local>
In-Reply-To: <YsfDm5q9wIyewtWR@B-P7TQMD6M-0146.local>
From: guowei du <duguoweisz@gmail.com>
Date: Fri, 8 Jul 2022 21:34:38 +0800
Message-ID: <CAC+1Nxt_UL_0rSdEfJCaKKan1sA5aYrN1ev9pyUGF4VXPxRkJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] erofs: sequence each shrink task
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="0000000000002a788e05e34b44c5"
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>, duguowei <duguowei@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--0000000000002a788e05e34b44c5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it.

Thanks very much.

On Fri, Jul 8, 2022 at 1:41 PM Gao Xiang <hsiangkao@linux.alibaba.com>
wrote:

> Hi,
>
> On Fri, Jul 08, 2022 at 12:49:07PM +0800, guowei du wrote:
> > hi,
> > I am sorry=EF=BC=8Cthere is only one patch.
> >
> > If two or more tasks are doing a shrinking job, there are different
> results
> > for each task.
> > That is to say, the status of each task is not persistent each time,
> > although they have
> > the same purpose to release memory.
> >
> > And, If two tasks are shrinking, the erofs_sb_list will become no order=
,
> > because each task will
> > move one sbi to tail, but sbi is random, so results are more complex.
>
> Thanks for the explanation. So it doesn't sound like a real issue but see=
ms
> like an improvement? If it's more like this, you could patch this to the
> products first and beta for more time and see if it works well.. I'm
> more careful about such change to shrinker since it could impact
> downstream users...
>
> Yes, I know this behavior, but I'm not sure if it's needed to be treated
> as this way, because in principle shrinker can be processed by multiple
> tasks since otherwise it could be stuck by some low priority task (I
> remember it sometimes happens in Android.)
>
> >
> > Because of the use of the local variable 'run_no', it took me a long ti=
me
> > to understand the
> > procedure of each task when they are concurrent.
> >
> > There is the same issue for other fs, such as
> > fs/ubifs/shrink.c=E3=80=81fs/f2fs/shrink.c.
> >
> > If scan_objects cost a long time ,it will trigger a watchdog, shrinking
> > should
> > not make work time-consuming. It should be done ASAP.
> > So, I add a new spin lock to let tasks shrink fs sequentially, it will
> just
> > make all tasks shrink
> > one by one.
>
> Actually such shrinker is used for managed slots (sorry I needs more
> work to rename workgroup to such name). But currently one of my ongoing
> improvements is to remove pclusters immediately from managed slots if
> no compressed buffer is cached, so it's used for inflight I/Os (to merge
> decompression requests, including ongoing deduplication requests) and
> cached I/O only.  So in that way objects will be more fewer than now.
>
> >
> >
> > Thanks very much.
>
> Thank you.
>
> Thanks,
> Gao Xiang
>
>

--0000000000002a788e05e34b44c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Got it.=C2=A0<br><div><br></div><div>Thanks very much.</di=
v></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Fri, Jul 8, 2022 at 1:41 PM Gao Xiang &lt;<a href=3D"mailto:hsiangkao@=
linux.alibaba.com">hsiangkao@linux.alibaba.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Fri, Jul 08, 2022 at 12:49:07PM +0800, guowei du wrote:<br>
&gt; hi,<br>
&gt; I am sorry=EF=BC=8Cthere is only one patch.<br>
&gt; <br>
&gt; If two or more tasks are doing a shrinking job, there are different re=
sults<br>
&gt; for each task.<br>
&gt; That is to say, the status of each task is not persistent each time,<b=
r>
&gt; although they have<br>
&gt; the same purpose to release memory.<br>
&gt; <br>
&gt; And, If two tasks are shrinking, the erofs_sb_list will become no orde=
r,<br>
&gt; because each task will<br>
&gt; move one sbi to tail, but sbi is random, so results are more complex.<=
br>
<br>
Thanks for the explanation. So it doesn&#39;t sound like a real issue but s=
eems<br>
like an improvement? If it&#39;s more like this, you could patch this to th=
e<br>
products first and beta for more time and see if it works well.. I&#39;m<br=
>
more careful about such change to shrinker since it could impact<br>
downstream users...<br>
<br>
Yes, I know this behavior, but I&#39;m not sure if it&#39;s needed to be tr=
eated<br>
as this way, because in principle shrinker can be processed by multiple<br>
tasks since otherwise it could be stuck by some low priority task (I<br>
remember it sometimes happens in Android.)<br>
<br>
&gt; <br>
&gt; Because of the use of the local variable &#39;run_no&#39;, it took me =
a long time<br>
&gt; to understand the<br>
&gt; procedure of each task when they are concurrent.<br>
&gt; <br>
&gt; There is the same issue for other fs, such as<br>
&gt; fs/ubifs/shrink.c=E3=80=81fs/f2fs/shrink.c.<br>
&gt; <br>
&gt; If scan_objects cost a long time ,it will trigger a watchdog, shrinkin=
g<br>
&gt; should<br>
&gt; not make work time-consuming. It should be done ASAP.<br>
&gt; So, I add a new spin lock to let tasks shrink fs sequentially, it will=
 just<br>
&gt; make all tasks shrink<br>
&gt; one by one.<br>
<br>
Actually such shrinker is used for managed slots (sorry I needs more<br>
work to rename workgroup to such name). But currently one of my ongoing<br>
improvements is to remove pclusters immediately from managed slots if<br>
no compressed buffer is cached, so it&#39;s used for inflight I/Os (to merg=
e<br>
decompression requests, including ongoing deduplication requests) and<br>
cached I/O only.=C2=A0 So in that way objects will be more fewer than now.<=
br>
<br>
&gt; <br>
&gt; <br>
&gt; Thanks very much.<br>
<br>
Thank you.<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
</blockquote></div>

--0000000000002a788e05e34b44c5--
