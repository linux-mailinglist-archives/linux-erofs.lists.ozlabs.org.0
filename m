Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8022FCA27
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Jan 2021 05:58:26 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DLCw00jwJzDqYP
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Jan 2021 15:58:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DLCvn6pBFzDqG0
 for <linux-erofs@lists.ozlabs.org>; Wed, 20 Jan 2021 15:58:09 +1100 (AEDT)
Received: from [192.168.43.20] (unknown [113.115.40.34])
 by front (Coremail) with SMTP id AWSowAAnLQU1uAdgw_rTAQ--.61228S2;
 Wed, 20 Jan 2021 12:57:27 +0800 (CST)
Content-Type: multipart/alternative;
 boundary=Apple-Mail-5FE531C4-B5B1-4CAB-823C-0947073B8D9A
Content-Transfer-Encoding: 7bit
From: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] erofs-utils: fix battach on full buffer block
Date: Wed, 20 Jan 2021 12:57:39 +0800
Message-Id: <32A61DA5-EED5-4268-B6C5-CAAB94527F91@mail.scut.edu.cn>
References: <20210119154335.GB2601261@xiangao.remote.csb>
In-Reply-To: <20210119154335.GB2601261@xiangao.remote.csb>
To: Gao Xiang <hsiangkao@redhat.com>
X-Mailer: iPad Mail (18C66)
X-CM-TRANSID: AWSowAAnLQU1uAdgw_rTAQ--.61228S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWkKF4kGF1rWF1kAry7ZFb_yoW8ZF4rp3
 9rK3WkKrWktF1vyr1xJw12v34Iy3s5Gr93Kry5uryvvrZxXFy8CryIkr4j93srX397AFWj
 va18uwn5Jay5Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyab7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21lYx0E2Ix0
 cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
 ACjcxG0xvY0x0EwIxGrwCjr7xvwVCIw2I0I7xG6c02F41l42xK82IYc2Ij64vIr41l4I8I
 3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUGVWUWwC20s026x8GjcxK67AKxV
 WUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
 wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
 k0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
 Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8wYFtUUUUU==
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAFBlepTBDbiwAVsl
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


--Apple-Mail-5FE531C4-B5B1-4CAB-823C-0947073B8D9A
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable


> =E5=9C=A8 2021=E5=B9=B41=E6=9C=8819=E6=97=A5=EF=BC=8C23:43=EF=BC=8CGao Xia=
ng <hsiangkao@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> =EF=BB=BFHi Weiwen,
>=20
>> On Tue, Jan 19, 2021 at 02:02:56PM +0800, =E8=83=A1=E7=8E=AE=E6=96=87 wro=
te:
>> Hi Xiang,
>>=20
>> After further investgate, this bug will not reveal in any released versio=
n of
>> mkfs.erofs. Previous patch v5 [1] will map all allocated bb when erofs_ma=
pbh()
>> is called on an already mapped bb, which triggers this bug. before that p=
atch,
>> under the same condition, __erofs_battach() will only be called on bb whi=
ch is
>> not mapped, thus no need to update `tail_blkaddr'.
>=20
> Good to know this, thanks! I haven't looked into that (I will test it this=

> weekend.) IMO, although this is not a regression, yet it seems it's potent=
ial
> harmful if we didn't notice this... So I think a proper testcase is still
> useful to look after this... If you have extra time, could you help on it?=


Hi Xiang,

I=E2=80=99m working on this. I have written a test case for this. And I=E2=80=
=99m also working on setting up GitHub actions to run tests automatically. S=
o far, I=E2=80=99ve got uncompressed tests works, but when lz4 is enable, al=
l test (except 001) fail. I have not found out why. You may see my progress a=
t https://github.com/huww98/erofs-utils/tree/experimental-tests. I will send=
 patches once everything is sorted out.

> Also, without the detail of this, I think the fix might be folded into
> the original patchset (could you resend it?). In addition, I think after

You mean add a new commit [PATCH v6 3/3], or merge it into [PATCH v7 2/2]? I=
 send it as a separate patch set because it may be merged independent of the=
 cache.c optimization.

> last_mapped_block is introduced, we might not need tail_blkaddr anymore,
> not sure. But I'm very cautious about this in case of introducing any
> new regression...

I think we still need it, because already mapped bb may be dropped, last_map=
_block does not always reflect tail_blkaddr.

Hu Weiwen

> Thanks,
> Gao Xiang
>=20
>>=20
>> [1]: https://lore.kernel.org/linux-erofs/20210118123431.22533-1-sehuww@ma=
il.scut.edu.cn/
>>=20
>> Hu Weiwen
>>=20

--Apple-Mail-5FE531C4-B5B1-4CAB-823C-0947073B8D9A
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><br><div dir=3D"ltr"><blockquote type=3D"ci=
te">=E5=9C=A8 2021=E5=B9=B41=E6=9C=8819=E6=97=A5=EF=BC=8C23:43=EF=BC=8CGao X=
iang &lt;hsiangkao@redhat.com&gt; =E5=86=99=E9=81=93=EF=BC=9A<br><br></block=
quote></div><blockquote type=3D"cite"><div dir=3D"ltr">=EF=BB=BF<span>Hi Wei=
wen,</span><br><span></span><br><span>On Tue, Jan 19, 2021 at 02:02:56PM +08=
00, =E8=83=A1=E7=8E=AE=E6=96=87 wrote:</span><br><blockquote type=3D"cite"><=
span>Hi Xiang,</span><br></blockquote><blockquote type=3D"cite"><span></span=
><br></blockquote><blockquote type=3D"cite"><span>After further investgate, t=
his bug will not reveal in any released version of</span><br></blockquote><b=
lockquote type=3D"cite"><span>mkfs.erofs. Previous patch v5 [1] will map all=
 allocated bb when erofs_mapbh()</span><br></blockquote><blockquote type=3D"=
cite"><span>is called on an already mapped bb, which triggers this bug. befo=
re that patch,</span><br></blockquote><blockquote type=3D"cite"><span>under t=
he same condition, __erofs_battach() will only be called on bb which is</spa=
n><br></blockquote><blockquote type=3D"cite"><span>not mapped, thus no need t=
o update `tail_blkaddr'.</span><br></blockquote><span></span><br><span>Good t=
o know this, thanks! I haven't looked into that (I will test it this</span><=
br><span>weekend.) IMO, although this is not a regression, yet it seems it's=
 potential</span><br><span>harmful if we didn't notice this... So I think a p=
roper testcase is still</span><br><span>useful to look after this... If you h=
ave extra time, could you help on it?</span><br></div></blockquote><div><br>=
</div><div>Hi Xiang,</div><div><br></div><div>I=E2=80=99m working on this. I=
 have written a test case for this. And I=E2=80=99m also working on setting u=
p GitHub actions to run tests automatically. So far, I=E2=80=99ve got uncomp=
ressed tests works, but when lz4 is enable, all test (except 001) fail. I ha=
ve not found out why. You may see my progress at&nbsp;<a href=3D"https://git=
hub.com/huww98/erofs-utils/tree/experimental-tests">https://github.com/huww9=
8/erofs-utils/tree/experimental-tests</a>. I will send patches once everythi=
ng is sorted out.</div><br><blockquote type=3D"cite"><div dir=3D"ltr"><span>=
Also, without the detail of this, I think the fix might be folded into</span=
><br><span>the original patchset (could you resend it?). In addition, I thin=
k after</span><br></div></blockquote><div><br></div><div>You mean add a new c=
ommit [PATCH v6 3/3], or merge it into [PATCH v7 2/2]? I send it as a separa=
te patch set because it may be merged independent of the cache.c optimizatio=
n.</div><br><blockquote type=3D"cite"><div dir=3D"ltr"><span>last_mapped_blo=
ck is introduced, we might not need tail_blkaddr anymore,</span><br><span>no=
t sure. But I'm very cautious about this in case of introducing any</span><b=
r><span>new regression...</span><br></div></blockquote><div><br></div>I thin=
k we still need it, because already mapped bb may be dropped, last_map_block=
 does not always reflect tail_blkaddr.<div><br></div><div>Hu Weiwen<br><br><=
blockquote type=3D"cite"><div dir=3D"ltr"><span>Thanks,</span><br><span>Gao X=
iang</span><br><span></span><br><blockquote type=3D"cite"><span></span><br><=
/blockquote><blockquote type=3D"cite"><span>[1]: https://lore.kernel.org/lin=
ux-erofs/20210118123431.22533-1-sehuww@mail.scut.edu.cn/</span><br></blockqu=
ote><blockquote type=3D"cite"><span></span><br></blockquote><blockquote type=
=3D"cite"><span>Hu Weiwen</span><br></blockquote><blockquote type=3D"cite"><=
span></span><br></blockquote></div></blockquote></div></body></html>=

--Apple-Mail-5FE531C4-B5B1-4CAB-823C-0947073B8D9A--

