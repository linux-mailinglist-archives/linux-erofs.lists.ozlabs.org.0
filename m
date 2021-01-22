Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B37D82FF9CF
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 02:11:03 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMLmj068LzDrbn
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 12:11:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DMLl406vCzDrbB
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 12:09:35 +1100 (AEDT)
Received: from [10.1.128.116] (unknown [10.1.128.116])
 by front (Coremail) with SMTP id AWSowAAHDga0JQpgtjfeAQ--.64558S2;
 Fri, 22 Jan 2021 09:09:08 +0800 (CST)
Content-Type: multipart/alternative;
 boundary=Apple-Mail-4587E273-77BA-4A57-B900-3EA441E3DCD9
Content-Transfer-Encoding: 7bit
From: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 4/7] erofs-utils: tests: fix distcheck
Date: Fri, 22 Jan 2021 09:09:23 +0800
Message-Id: <EC813CDC-6EC3-4FBB-BAD9-674982559F68@mail.scut.edu.cn>
References: <20210122001605.GC2996701@xiangao.remote.csb>
In-Reply-To: <20210122001605.GC2996701@xiangao.remote.csb>
To: Gao Xiang <hsiangkao@redhat.com>
X-Mailer: iPad Mail (18C66)
X-CM-TRANSID: AWSowAAHDga0JQpgtjfeAQ--.64558S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWDZw1DCw17WFy3Xw45Awb_yoW8Xr1rpa
 47G3Wjywn5tr4kAw1xCr1Iqa4xA395KFy5Xr1rW348X3yYq34xtFWIvr4rGr97WrZ8W3yS
 vayYq3s0yF9Yva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkYb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21lYx0E2Ix0
 cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
 ACjcxG0xvY0x0EwIxGrwCjr7xvwVCIw2I0I7xG6c02F41lc2xSY4AK6svPMxAIw28IcxkI
 7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_JrI_JrWlx2IqxV
 Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY
 6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
 AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
 aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1C385UUUUU==
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAJBlepTBDjTQABsD
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--Apple-Mail-4587E273-77BA-4A57-B900-3EA441E3DCD9
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable


> =E5=9C=A8 2021=E5=B9=B41=E6=9C=8822=E6=97=A5=EF=BC=8C08:16=EF=BC=8CGao Xia=
ng <hsiangkao@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> =EF=BB=BFHi Weiwen,
>=20
>> On Fri, Jan 22, 2021 at 12:37:12AM +0800, Hu Weiwen wrote:
>> To get required files to final .tar.gz distribution:
>> * Any header files should goes into _SOURCES.
>=20
> should we use noinst_HEADERS instead? do you have some reference
> link (I mean document) for this? what's the impact of this,
> just dictcheck? I'm not familiar with that...

https://www.gnu.org/software/automake/manual/automake.html#Program-Sources

I quote from above link:

Header files listed in a _SOURCES definition will be included in the distrib=
ution but otherwise ignored

>> * check scripts should goes into dist_check_SCRIPTS.
>> * 001.out will trigger a GNU make implicit rule, rename it to 001-out
>=20
> How about also renaming $tmp.out to $tmp.stdout?

Yes, that should work.

> Also, 'since experimental-tests' has't merged into dev, do you mind
> me folding these bugfix patches (I mean except for "[PATCH 5/7] and
> [PATCH 7/7]") into the original patches, and add your contribution
> description & SOB(Signed-off-by:) to the commit message? That would
> make the whole commit history much cleaner... If you agree that, I
> will resend the testcase patchset later with your fixes and new
> patches and wait for Guifu to review if he has extra free slots.

Okay.

> Note that, only dev & master branches have stable commit ids.
> experimental-xxx could be rebased frequently.
>=20
> Thanks,
> Gao Xiang

--Apple-Mail-4587E273-77BA-4A57-B900-3EA441E3DCD9
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><br><div dir=3D"ltr"><blockquote type=3D"ci=
te">=E5=9C=A8 2021=E5=B9=B41=E6=9C=8822=E6=97=A5=EF=BC=8C08:16=EF=BC=8CGao X=
iang &lt;hsiangkao@redhat.com&gt; =E5=86=99=E9=81=93=EF=BC=9A<br><br></block=
quote></div><blockquote type=3D"cite"><div dir=3D"ltr">=EF=BB=BF<span>Hi Wei=
wen,</span><br><span></span><br><span>On Fri, Jan 22, 2021 at 12:37:12AM +08=
00, Hu Weiwen wrote:</span><br><blockquote type=3D"cite"><span>To get requir=
ed files to final .tar.gz distribution:</span><br></blockquote><blockquote t=
ype=3D"cite"><span>* Any header files should goes into _SOURCES.</span><br><=
/blockquote><span></span><br><span>should we use noinst_HEADERS instead? do y=
ou have some reference</span><br><span>link (I mean document) for this? what=
's the impact of this,</span><br><span>just dictcheck? I'm not familiar with=
 that...</span><br></div></blockquote><div><br></div><div><a href=3D"https:/=
/www.gnu.org/software/automake/manual/automake.html#Program-Sources">https:/=
/www.gnu.org/software/automake/manual/automake.html#Program-Sources</a></div=
><div><br></div><div>I quote from above link:</div><div><br></div><div><span=
 style=3D"font-size: 16px; -webkit-text-size-adjust: auto; background-color:=
 rgb(255, 255, 255);">Header files listed in a&nbsp;</span><code style=3D"-w=
ebkit-text-size-adjust: auto; margin: 0px; padding: 0px; line-height: 1.5em;=
">_SOURCES</code><span style=3D"font-size: 16px; -webkit-text-size-adjust: a=
uto; background-color: rgb(255, 255, 255);">&nbsp;definition will be include=
d in the distribution but otherwise ignored</span></div><br><blockquote type=
=3D"cite"><div dir=3D"ltr"><blockquote type=3D"cite"><span>* check scripts s=
hould goes into dist_check_SCRIPTS.</span><br></blockquote><blockquote type=3D=
"cite"><span>* 001.out will trigger a GNU make implicit rule, rename it to 0=
01-out</span><br></blockquote><span></span><br><span>How about also renaming=
 $tmp.out to $tmp.stdout?</span><br></div></blockquote><div><br></div><div>Y=
es, that should work.</div><br><blockquote type=3D"cite"><div dir=3D"ltr"><s=
pan>Also, 'since experimental-tests' has't merged into dev, do you mind</spa=
n><br><span>me folding these bugfix patches (I mean except for "[PATCH 5/7] a=
nd</span><br><span>[PATCH 7/7]") into the original patches, and add your con=
tribution</span><br><span>description &amp; SOB(Signed-off-by:) to the commi=
t message? That would</span><br><span>make the whole commit history much cle=
aner... If you agree that, I</span><br><span>will resend the testcase patchs=
et later with your fixes and new</span><br><span>patches and wait for Guifu t=
o review if he has extra free slots.</span><br></div></blockquote><div><br><=
/div><div>Okay.</div><br><blockquote type=3D"cite"><div dir=3D"ltr"><span>No=
te that, only dev &amp; master branches have stable commit ids.</span><br><s=
pan>experimental-xxx could be rebased frequently.</span><br><span></span><br=
><span>Thanks,</span><br><span>Gao Xiang</span><br></div></blockquote></body=
></html>=

--Apple-Mail-4587E273-77BA-4A57-B900-3EA441E3DCD9--

