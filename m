Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE7356B1DC
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Jul 2022 06:49:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LfLRJ1k1rz3c3c
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Jul 2022 14:49:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=VSToPxvj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=duguoweisz@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=VSToPxvj;
	dkim-atps=neutral
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LfLR86gxhz3bs2
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Jul 2022 14:49:23 +1000 (AEST)
Received: by mail-ej1-x62c.google.com with SMTP id dn9so30501786ejc.7
        for <linux-erofs@lists.ozlabs.org>; Thu, 07 Jul 2022 21:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbydV7PS0CjWX11Qbu6hg+p1BR+5xIWUySV38hyWFcs=;
        b=VSToPxvjd7teiZ44JErF1a2l2WrSddbWcJ5Y2XVUwcUg1F4yn++/NQjlFsamfWjQm7
         /RTgFFtUkdGlP9ysDRQsya095o/tOM8fa1hEVjiPeXCkkdJpK7JZhchg9IujCfvch5vC
         47AdhM8RHTd7mYyVwKrD02+JZwcZNSE+85khfuHd7V0zU5mhUvG2MH6bd26CGglsEXcY
         gYH+NgJ973LczdBYXIaQO7sm6Kc2FLFbvQMwt7o8E1DTwWHIF8RzzC2m7hxEpQvpcDxL
         lxO8iuol/ADctkqUnAyUCb+hDfUtz3/f/gqpQNdrXT8YXSxdqAINE1sDIx86v/11ebvF
         BC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbydV7PS0CjWX11Qbu6hg+p1BR+5xIWUySV38hyWFcs=;
        b=0J8u/yVGTqk0yc1xfJNSo2rKpGewxIIrmYaAZ2Jcx0W5C2CK6G95e1a/D/8ZhsjWnQ
         3IpJr9nDPf5KroBtKVXaEBhnRO+DZWyZcWxGBsMURvKRbTgL96KPfz9sbycSpHytWtCz
         clvzDLLg84ZnHLWSwEuLseWQ/R9EPMrPkFVx5V24EFcjYJGQHKNHWay99fIIOaK8FPPL
         nzk2Q7jevp0NlpP7S4RtpwQfWRxfyXJXyWHuOZMGdSCbetf2c0nYIjpHmSZ9dhoILalF
         VIWVyEv7WmCulcpTRhkKcxV4x/uWm1pmctUCtl8b8ed2YAQVk8E0yUX+A5ebeDqA4V7P
         ofvQ==
X-Gm-Message-State: AJIora/9mzS4xpEs0z33Tviluf+z3OSkvX4gHJxirzDHY0KeZJZRDDuv
	Ckd8nhFcwB9mduLa+pR0iPB7gqWARA8HljPFVwI=
X-Google-Smtp-Source: AGRyM1uIzLUGKG/tO3K+U+Gbkgc/bqcuV+fzUjGvG+goR9MQM1ia1tc2EOEHRIPebz37Rj92TO1DbvHt9sqBxk69odw=
X-Received: by 2002:a17:907:2cd3:b0:72a:b4a4:2fc4 with SMTP id
 hg19-20020a1709072cd300b0072ab4a42fc4mr1699289ejc.70.1657255757306; Thu, 07
 Jul 2022 21:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220708031155.21878-1-duguoweisz@gmail.com> <YsejnaY7cy3SeHBF@B-P7TQMD6M-0146.local>
In-Reply-To: <YsejnaY7cy3SeHBF@B-P7TQMD6M-0146.local>
From: guowei du <duguoweisz@gmail.com>
Date: Fri, 8 Jul 2022 12:49:07 +0800
Message-ID: <CAC+1NxvifeHmrerWUqhC-gCUk11vudLVc=o=Hnr5EwYJv+N0ZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] erofs: sequence each shrink task
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000b75ec705e343ec47"
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

--000000000000b75ec705e343ec47
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi,
I am sorry=EF=BC=8Cthere is only one patch.

If two or more tasks are doing a shrinking job, there are different results
for each task.
That is to say, the status of each task is not persistent each time,
although they have
the same purpose to release memory.

And, If two tasks are shrinking, the erofs_sb_list will become no order,
because each task will
move one sbi to tail, but sbi is random, so results are more complex.

Because of the use of the local variable 'run_no', it took me a long time
to understand the
procedure of each task when they are concurrent.

There is the same issue for other fs, such as
fs/ubifs/shrink.c=E3=80=81fs/f2fs/shrink.c.

If scan_objects cost a long time ,it will trigger a watchdog, shrinking
should
not make work time-consuming. It should be done ASAP.
So, I add a new spin lock to let tasks shrink fs sequentially, it will just
make all tasks shrink
one by one.


Thanks very much.



On Fri, Jul 8, 2022 at 11:25 AM Gao Xiang <hsiangkao@linux.alibaba.com>
wrote:

> Hi Guowei,
>
> On Fri, Jul 08, 2022 at 11:11:55AM +0800, Guowei Du wrote:
> > From: duguowei <duguowei@xiaomi.com>
> >
> > Because of 'list_move_tail', if two or more tasks are shrinking, there
> > will be different results for them.
>
> Thanks for the patch. Two quick questions:
>  1) where is the PATCH 1/2;
>  2) What problem is the current patch trying to resolve...
>
> >
> > For example:
> > After the first round, if shrink_run_no of entry equals run_no of task,
> > task will break directly at the beginning of next round; if they are
> > not equal, task will continue to shrink until encounter one entry
> > which has the same number.
> >
> > It is difficult to confirm the real results of all tasks, so add a lock
> > to only allow one task to shrink at the same time.
> >
> > How to test:
> > task1:
> > root#echo 3 > /proc/sys/vm/drop_caches
> > [743071.839051] Call Trace:
> > [743071.839052]  <TASK>
> > [743071.839054]  do_shrink_slab+0x112/0x300
> > [743071.839058]  shrink_slab+0x211/0x2a0
> > [743071.839060]  drop_slab+0x72/0xe0
> > [743071.839061]  drop_caches_sysctl_handler+0x50/0xb0
> > [743071.839063]  proc_sys_call_handler+0x173/0x250
> > [743071.839066]  proc_sys_write+0x13/0x20
> > [743071.839067]  new_sync_write+0x104/0x180
> > [743071.839070]  ? send_command+0xe0/0x270
> > [743071.839073]  vfs_write+0x247/0x2a0
> > [743071.839074]  ksys_write+0xa7/0xe0
> > [743071.839075]  ? fpregs_assert_state_consistent+0x23/0x50
> > [743071.839078]  __x64_sys_write+0x1a/0x20
> > [743071.839079]  do_syscall_64+0x3a/0x80
> > [743071.839081]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> >
> > task2:
> > root#echo 3 > /proc/sys/vm/drop_caches
> > [743079.843214] Call Trace:
> > [743079.843214]  <TASK>
> > [743079.843215]  do_shrink_slab+0x112/0x300
> > [743079.843219]  shrink_slab+0x211/0x2a0
> > [743079.843221]  drop_slab+0x72/0xe0
> > [743079.843222]  drop_caches_sysctl_handler+0x50/0xb0
> > [743079.843224]  proc_sys_call_handler+0x173/0x250
> > [743079.843227]  proc_sys_write+0x13/0x20
> > [743079.843228]  new_sync_write+0x104/0x180
> > [743079.843231]  ? send_command+0xe0/0x270
> > [743079.843233]  vfs_write+0x247/0x2a0
> > [743079.843234]  ksys_write+0xa7/0xe0
> > [743079.843235]  ? fpregs_assert_state_consistent+0x23/0x50
> > [743079.843238]  __x64_sys_write+0x1a/0x20
> > [743079.843239]  do_syscall_64+0x3a/0x80
> > [743079.843241]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> >
> > Signed-off-by: duguowei <duguowei@xiaomi.com>
> > ---
> >  fs/erofs/utils.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
> > index ec9a1d780dc1..9eca13a7e594 100644
> > --- a/fs/erofs/utils.c
> > +++ b/fs/erofs/utils.c
> > @@ -186,6 +186,8 @@ static unsigned int shrinker_run_no;
> >
> >  /* protects the mounted 'erofs_sb_list' */
> >  static DEFINE_SPINLOCK(erofs_sb_list_lock);
> > +/* sequence each shrink task */
> > +static DEFINE_SPINLOCK(erofs_sb_shrink_lock);
> >  static LIST_HEAD(erofs_sb_list);
> >
> >  void erofs_shrinker_register(struct super_block *sb)
> > @@ -226,13 +228,14 @@ static unsigned long erofs_shrink_scan(struct
> shrinker *shrink,
> >       struct list_head *p;
> >
> >       unsigned long nr =3D sc->nr_to_scan;
> > -     unsigned int run_no;
> >       unsigned long freed =3D 0;
> >
> > +     spin_lock(&erofs_sb_shrink_lock);
>
> Btw, we cannot make the whole shrinker under one spin_lock.
>
> Thanks,
> Gao Xiang
>

--000000000000b75ec705e343ec47
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">hi,<div>I am sorry=EF=BC=8Cthere is only one patch.</div><=
div><br></div><div>If two or more tasks are doing a shrinking job, there ar=
e different results for each task.=C2=A0</div><div>That is to say, the stat=
us of each task is not persistent each time, although they have</div><div>t=
he same purpose to release memory.</div><div><br></div><div><div>And, If tw=
o tasks are shrinking, the=C2=A0erofs_sb_list will become no order, because=
 each task will</div><div>move one sbi to tail, but sbi is random, so resul=
ts are more complex.</div></div><div><br></div><div><div>Because of the use=
 of the local variable &#39;run_no&#39;, it took me a long time to understa=
nd the=C2=A0</div><div>procedure of each task when they are concurrent.=C2=
=A0</div><div><br></div><div>There is the same issue for other fs, such as =
fs/ubifs/shrink.c=E3=80=81fs/f2fs/shrink.c.</div></div><div><br></div><div>=
<div>If scan_objects cost a long time ,it will trigger a watchdog, shrinkin=
g should</div><div>not make work=C2=A0time-consuming. It should be done ASA=
P.</div><div>So, I add a new spin lock to let tasks shrink fs sequentially,=
 it will just make all tasks shrink</div><div>one by one.</div></div><div><=
br></div><div><br></div><div>Thanks very much.</div><div><br></div><div><br=
></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Fri, Jul 8, 2022 at 11:25 AM Gao Xiang &lt;<a href=3D"mailto:hsia=
ngkao@linux.alibaba.com">hsiangkao@linux.alibaba.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Guowei,<br>
<br>
On Fri, Jul 08, 2022 at 11:11:55AM +0800, Guowei Du wrote:<br>
&gt; From: duguowei &lt;<a href=3D"mailto:duguowei@xiaomi.com" target=3D"_b=
lank">duguowei@xiaomi.com</a>&gt;<br>
&gt; <br>
&gt; Because of &#39;list_move_tail&#39;, if two or more tasks are shrinkin=
g, there<br>
&gt; will be different results for them.<br>
<br>
Thanks for the patch. Two quick questions:<br>
=C2=A01) where is the PATCH 1/2;<br>
=C2=A02) What problem is the current patch trying to resolve...<br>
<br>
&gt; <br>
&gt; For example:<br>
&gt; After the first round, if shrink_run_no of entry equals run_no of task=
,<br>
&gt; task will break directly at the beginning of next round; if they are<b=
r>
&gt; not equal, task will continue to shrink until encounter one entry<br>
&gt; which has the same number.<br>
&gt; <br>
&gt; It is difficult to confirm the real results of all tasks, so add a loc=
k<br>
&gt; to only allow one task to shrink at the same time.<br>
&gt; <br>
&gt; How to test:<br>
&gt; task1:<br>
&gt; root#echo 3 &gt; /proc/sys/vm/drop_caches<br>
&gt; [743071.839051] Call Trace:<br>
&gt; [743071.839052]=C2=A0 &lt;TASK&gt;<br>
&gt; [743071.839054]=C2=A0 do_shrink_slab+0x112/0x300<br>
&gt; [743071.839058]=C2=A0 shrink_slab+0x211/0x2a0<br>
&gt; [743071.839060]=C2=A0 drop_slab+0x72/0xe0<br>
&gt; [743071.839061]=C2=A0 drop_caches_sysctl_handler+0x50/0xb0<br>
&gt; [743071.839063]=C2=A0 proc_sys_call_handler+0x173/0x250<br>
&gt; [743071.839066]=C2=A0 proc_sys_write+0x13/0x20<br>
&gt; [743071.839067]=C2=A0 new_sync_write+0x104/0x180<br>
&gt; [743071.839070]=C2=A0 ? send_command+0xe0/0x270<br>
&gt; [743071.839073]=C2=A0 vfs_write+0x247/0x2a0<br>
&gt; [743071.839074]=C2=A0 ksys_write+0xa7/0xe0<br>
&gt; [743071.839075]=C2=A0 ? fpregs_assert_state_consistent+0x23/0x50<br>
&gt; [743071.839078]=C2=A0 __x64_sys_write+0x1a/0x20<br>
&gt; [743071.839079]=C2=A0 do_syscall_64+0x3a/0x80<br>
&gt; [743071.839081]=C2=A0 entry_SYSCALL_64_after_hwframe+0x46/0xb0<br>
&gt; <br>
&gt; task2:<br>
&gt; root#echo 3 &gt; /proc/sys/vm/drop_caches<br>
&gt; [743079.843214] Call Trace:<br>
&gt; [743079.843214]=C2=A0 &lt;TASK&gt;<br>
&gt; [743079.843215]=C2=A0 do_shrink_slab+0x112/0x300<br>
&gt; [743079.843219]=C2=A0 shrink_slab+0x211/0x2a0<br>
&gt; [743079.843221]=C2=A0 drop_slab+0x72/0xe0<br>
&gt; [743079.843222]=C2=A0 drop_caches_sysctl_handler+0x50/0xb0<br>
&gt; [743079.843224]=C2=A0 proc_sys_call_handler+0x173/0x250<br>
&gt; [743079.843227]=C2=A0 proc_sys_write+0x13/0x20<br>
&gt; [743079.843228]=C2=A0 new_sync_write+0x104/0x180<br>
&gt; [743079.843231]=C2=A0 ? send_command+0xe0/0x270<br>
&gt; [743079.843233]=C2=A0 vfs_write+0x247/0x2a0<br>
&gt; [743079.843234]=C2=A0 ksys_write+0xa7/0xe0<br>
&gt; [743079.843235]=C2=A0 ? fpregs_assert_state_consistent+0x23/0x50<br>
&gt; [743079.843238]=C2=A0 __x64_sys_write+0x1a/0x20<br>
&gt; [743079.843239]=C2=A0 do_syscall_64+0x3a/0x80<br>
&gt; [743079.843241]=C2=A0 entry_SYSCALL_64_after_hwframe+0x46/0xb0<br>
&gt; <br>
&gt; Signed-off-by: duguowei &lt;<a href=3D"mailto:duguowei@xiaomi.com" tar=
get=3D"_blank">duguowei@xiaomi.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 fs/erofs/utils.c | 16 ++++++++++------<br>
&gt;=C2=A0 1 file changed, 10 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c<br>
&gt; index ec9a1d780dc1..9eca13a7e594 100644<br>
&gt; --- a/fs/erofs/utils.c<br>
&gt; +++ b/fs/erofs/utils.c<br>
&gt; @@ -186,6 +186,8 @@ static unsigned int shrinker_run_no;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* protects the mounted &#39;erofs_sb_list&#39; */<br>
&gt;=C2=A0 static DEFINE_SPINLOCK(erofs_sb_list_lock);<br>
&gt; +/* sequence each shrink task */<br>
&gt; +static DEFINE_SPINLOCK(erofs_sb_shrink_lock);<br>
&gt;=C2=A0 static LIST_HEAD(erofs_sb_list);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 void erofs_shrinker_register(struct super_block *sb)<br>
&gt; @@ -226,13 +228,14 @@ static unsigned long erofs_shrink_scan(struct sh=
rinker *shrink,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head *p;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long nr =3D sc-&gt;nr_to_scan;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned int run_no;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long freed =3D 0;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0spin_lock(&amp;erofs_sb_shrink_lock);<br>
<br>
Btw, we cannot make the whole shrinker under one spin_lock.<br>
<br>
Thanks,<br>
Gao Xiang<br>
</blockquote></div>

--000000000000b75ec705e343ec47--
