Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3269555C432
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 14:49:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXPYf0Dkmz3c7N
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 22:49:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256 header.s=badeba3b8450 header.b=IVf3wNgI;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmx.com (client-ip=212.227.17.22; helo=mout.gmx.net; envelope-from=quwenruo.btrfs@gmx.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256 header.s=badeba3b8450 header.b=IVf3wNgI;
	dkim-atps=neutral
X-Greylist: delayed 312 seconds by postgrey-1.36 at boromir; Tue, 28 Jun 2022 22:49:18 AEST
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXPYV6zmJz3bsf
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Jun 2022 22:49:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1656420555;
	bh=oIyz5w0Qq/ZN49jah++J8wNTgX7aSIc99FECoLTXB6M=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IVf3wNgIhwYPJLThxxkHChrRa5a2QYWXOvK//Vunby0OMu5qncc5FjONF4HytaSB2
	 XDSiBJ5BM7aNzEtQDmmR2aXQleI0oz7/NT1rdjZIgblUcdUXZMxrqa2Niy/zz+RL0i
	 eXLDee0i81KFfjcgCMinUbnZP31OKztRAyLiL/vk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLQxX-1oNQCk229T-00IWZ8; Tue, 28
 Jun 2022 14:43:50 +0200
Message-ID: <c267985f-a1c5-5e86-f7b8-9c2f323d5547@gmx.com>
Date: Tue, 28 Jun 2022 20:43:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC 2/8] fs: always get the file size in _fs_read()
Content-Language: en-US
To: Huang Jianan <jnhuang95@gmail.com>, Qu Wenruo <wqu@suse.com>,
 u-boot@lists.denx.de
References: <cover.1656401086.git.wqu@suse.com>
 <cd417bc9dc4b44c4ac8d98f146e47c98cf4aac5a.1656401086.git.wqu@suse.com>
 <6f958407-0c3c-1cd6-ced2-08bc9c267d17@gmail.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <6f958407-0c3c-1cd6-ced2-08bc9c267d17@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zzrt6DchgYRalbPOVLdJYBaixymE0uGIISaZxdxJ3Mtekz3bPmw
 fN3HDLFiGK0L4rbfvBF8e8aFTPf5kn0VvAwx0EECTFFViYeN6Vkn5efSLTHI/wUF0Tnp+th
 +P7Oz5DwsgbIagtxU9a6xIBbPrh/UXG9WjpX36WcE3Vm9uqxkRBVaZzoS5ynGB8Go11rmbF
 DCujOHZQux5PfTamc7UnA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/TO5cJpBQfw=:mzZpbtb3EM9q8mRdVvznk5
 FctjZfDWCNWqamOLdAA5YfTAt3JjEhmnD9SsFXqVDNfidLuWUyehnaTR833JX6s38daHl5x8X
 VpnRN7xQBrWwbIxbDgF7ObZTiUNPkjsJjXOI1tJ3REBg1fyzdWj1sQyF1sP8R/79XWVlirSIs
 R+w5QoXQBGVJ0DixTfOZIZs2PRmkiVbZw5rmX1kHkU5h4MOKfq0KOROZvbsGm55zQyvNo39av
 fILcBRbCSoYnga6f4P9Xk29bRDVhrFZ3f3wgswqFa3zsE+WzB9jAdlekJWPsMHR6CJJ+iSxDx
 3v7o1K/snMHKnSdF+KRxkJYL9iVqpO/T+obIA681PV2mFTt1gykkT1krky2y26SfIscqojnXS
 1vfKOkrOeMr+oijivoG8ou6hdut/LWWl+viqDLlW5b986BwXUEV0pRd0AMqCzujvK6fYDw4+C
 FhEs5FCsSH5v2m4t44y/Vg59DM2KZLrf/VZZZBsGmZGihSQHD0IRwgsY3iFaZN58hlQ3wQynF
 g/6hxOzSb59X2gZ/Pt4FGthFG3Vnrm4YB1Bybqe3NinU0UkfP03n2Kmy39+X8xNnwnRkKpUp7
 C0YWSbr+E28kJqv3KRyYBl8Hj1PRceAffGY7Z4cA5eIRFyqPEFqcwaMGTCfh69bfHSOEvO24W
 MxCfRbri3dGyBzYJ8Ahe9FKHbIfLOgTsDXPqVsBHnJHZLFEVU4eXy7EituAx1DZIlKcde9aRt
 SPBjPKIBPErOsR7m5ymlvDF4S11l18Nf79yK3nKxrIoKNBS5l0E2xXWFj8qfvin4bHE+urF9J
 GjYHNKef3fjM0BwE0dhedcv0q9pEArAXgNVYshMlZe848VtXqIFSOVe5mkH3kuDU/D5DdiD3X
 xNszb00o9ycMvtpp12mdQLg6ICyLOsmm7d1V9h8vi2lefM3So60VJaf3l35s/mJy+S7bEQWsX
 w+8AuFyRfgZbUtJAy1G/PjRthWz9z/DUn+9vUWijt5/WKxGRp5En4Z7QMa44m17IwAcDh8uoz
 pUJAbal3XVd5YiAiAqj7Db5DT4hSnyJ0KS+gN5RiqLlBryn2KCI0Ma40lSsI+RIUIiFUyHP4H
 kKuUKke/zpG8qF1yK0L0gE9X1JywnnX18Te69ujBWSLL+hiF3/mux37XQ==
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
Cc: trini@konsulko.com, joaomarcos.costa@bootlin.com, marek.behun@nic.cz, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2022/6/28 20:36, Huang Jianan wrote:
> Hi, wenruo,
>
> =E5=9C=A8 2022/6/28 15:28, Qu Wenruo =E5=86=99=E9=81=93:
>> For _fs_read(), @len =3D=3D 0 means we read the whole file.
>> And we just pass @len =3D=3D 0 to make each filesystem to handle it.
>>
>> In fact we have info->size() call to properly get the filesize.
>>
>> So we can not only call info->size() to grab the file_size for len =3D=
=3D 0
>> case, but also detect invalid @len (e.g. @len > file_size) in advance o=
r
>> truncate @len.
>>
>> This behavior also allows us to handle unaligned better in the incoming
>> patches.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/fs.c | 25 +++++++++++++++++++++----
>> =C2=A0 1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/fs.c b/fs/fs.c
>> index 6de1a3eb6d5d..d992cdd6d650 100644
>> --- a/fs/fs.c
>> +++ b/fs/fs.c
>> @@ -579,6 +579,7 @@ static int _fs_read(const char *filename, ulong
>> addr, loff_t offset, loff_t len,
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct fstype_info *info =3D fs_get_info=
(fs_type);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *buf;
>> +=C2=A0=C2=A0=C2=A0 loff_t file_size;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> =C2=A0 #ifdef CONFIG_LMB
>> @@ -589,10 +590,26 @@ static int _fs_read(const char *filename, ulong
>> addr, loff_t offset, loff_t len,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 #endif
>> -=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * We don't actually know how many bytes are b=
eing read, since
>> len=3D=3D0
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * means read the whole file.
>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 ret =3D info->size(filename, &file_size);
>
> I get an error when running the erofs test cases. The return value isn't
> as expected
> when reading symlink file.
> For symlink file, erofs_size will return the size of the symlink itself
> here.

Indeed, this is a problem, in fact I also checked other fses, it looks
like we all just return the inode size for the softlink, thus size()
call can not be relied on for those cases.

While for the read() calls, every fs will do extra resolving for soft
links, thus it doesn't cause problems.


This can still be solved by not calling size() calls at all, and only do
the unaligned read handling for the leading block.

Thank you very much for pointing this bug out, would update the patchset
for that.

Thanks,
Qu
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_err("** Unable to get f=
ile size for %s, %d **\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 filename, ret);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (offset >=3D file_size) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_err(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "** Invalid offset, offset =
(%llu) >=3D file size (%llu)\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 off=
set, file_size);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (len =3D=3D 0 || offset + len > file_size) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (len > file_size)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log=
_info(
>> +=C2=A0=C2=A0=C2=A0 "** Truncate read length from %llu to %llu, as file=
 size is %llu
>> **\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 len, file_size, file_size);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =3D file_size - offset;
> Then, we will get a wrong len in the case of len=3D=3D0. So I think we n=
eed
> to do something
> extra with the symlink file?
>
> Thanks,
> Jianan
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf =3D map_sysmem(addr, len);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D info->read(filename, buf, offset=
, len, actread);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unmap_sysmem(buf);
>
