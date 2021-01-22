Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9688E2FF9B9
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 02:01:23 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMLYX5PPbzDrYX
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 12:01:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DMLY866WtzDrVX
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 12:00:58 +1100 (AEDT)
Received: from [10.1.128.116] (unknown [10.1.128.116])
 by front (Coremail) with SMTP id AWSowAD3_gasIwpgrS_eAQ--.64180S2;
 Fri, 22 Jan 2021 09:00:30 +0800 (CST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] erofs-utils: fuse: fix random readlink error
Date: Fri, 22 Jan 2021 09:00:44 +0800
Message-Id: <86D0E0EF-4F13-4410-80C1-19B829A4D61D@mail.scut.edu.cn>
References: <20210122003416.GF2996701@xiangao.remote.csb>
In-Reply-To: <20210122003416.GF2996701@xiangao.remote.csb>
To: Gao Xiang <hsiangkao@redhat.com>
X-Mailer: iPad Mail (18C66)
X-CM-TRANSID: AWSowAD3_gasIwpgrS_eAQ--.64180S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWktrWkur4fCFWxCF47CFg_yoW8trWkpr
 4YkF4DtF4Syry7Ar4Igr15Ga4Sq34Igr1UC3ykKay8Za47Arn8uFy8G3WY93s7CrWxCr40
 va12qF95uFWUJrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUymb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
 W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l
 4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
 AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
 cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
 8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
 wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAHBlepTBDfZQApsx
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

Hi Xiang,

> =E5=9C=A8 2021=E5=B9=B41=E6=9C=8822=E6=97=A5=EF=BC=8C08:34=EF=BC=8CGao Xia=
ng <hsiangkao@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> =EF=BB=BFHi Weiwen,
>=20
>> On Fri, Jan 22, 2021 at 12:31:43AM +0800, Hu Weiwen wrote:
>> readlink should fill a **null terminated** string in buffer.
>>=20
>> Also, read should return number of bytes remaining on EOF.
>>=20
>> Link: https://lore.kernel.org/linux-erofs/20210121101233.GC6680@DESKTOP-N=
4CECTO.huww98.cn/
>> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
>=20
> Thanks for catching this!
>=20
>> ---
>> fuse/main.c | 14 +++++++++++++-
>> 1 file changed, 13 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fuse/main.c b/fuse/main.c
>> index c162912..bc1e496 100644
>> --- a/fuse/main.c
>> +++ b/fuse/main.c
>> @@ -71,6 +71,12 @@ static int erofsfuse_read(const char *path, char *buff=
er,
>>    if (ret)
>>        return ret;
>>=20
>> +    if (offset >=3D vi.i_size)
>> +        return 0;
>> +
>> +    if (offset + size > vi.i_size)
>> +        size =3D vi.i_size - offset;
>> +
>=20
> It would be better to call erofs_pread() with the original offset
> and size (also I think there is some missing memset(0) for
> !EROFS_MAP_MAPPED), and fix up the return value to the needed value.

Yes, that is what I have initially tried. But this way is harder than I thou=
ght. EROFS_MAP_MAPPED flag seems to be designed to handle sparse file, and i=
s reused to represent EOF. So maybe we need a new flag to represent EOF? So t=
hat we can distinguish EOF and hole in the middle, and return the bytes read=
. Or we just abandon the sparse file support, and use EROFS_MAP_MAPPED to in=
dicate EOF exclusively. Since erofs current does not actually support this, r=
ight?

> Thanks,
> Gao Xiang
>=20
>>    ret =3D erofs_pread(&vi, buffer, size, offset);
>>    if (ret)
>>        return ret;
>> @@ -79,10 +85,16 @@ static int erofsfuse_read(const char *path, char *buf=
fer,
>>=20
>> static int erofsfuse_readlink(const char *path, char *buffer, size_t size=
)
>> {
>> -    int ret =3D erofsfuse_read(path, buffer, size, 0, NULL);
>> +    int ret;
>> +    size_t path_len;
>> +
>> +    erofs_dbg("path:%s size=3D%zd", path, size);
>> +    ret =3D erofsfuse_read(path, buffer, size, 0, NULL);
>>=20
>>    if (ret < 0)
>>        return ret;
>> +    path_len =3D min(size - 1, (size_t)ret);
>> +    buffer[path_len] =3D '\0';
>>    return 0;
>> }
>>=20
>> --=20
>> 2.30.0
>>=20

