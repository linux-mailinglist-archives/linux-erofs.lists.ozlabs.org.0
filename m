Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD51954B1
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2019 04:58:36 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46CFqF352QzDr5s
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2019 12:58:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.com
 (client-ip=212.227.17.21; helo=mout.gmx.net;
 envelope-from=quwenruo.btrfs@gmx.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=gmx.net header.i=@gmx.net header.b="iNZz6s0d"; 
 dkim-atps=neutral
X-Greylist: delayed 377 seconds by postgrey-1.36 at bilbo;
 Tue, 20 Aug 2019 12:46:57 AEST
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46CFYs1zwJzDqyH
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2019 12:46:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1566269197;
 bh=XFD/O+kTU7Pa5pUSpZUbhX3uJjyCLY7mxh4UOLO+LSU=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=iNZz6s0du+QqLCXE3O/REvVi+6QOquPk0EaHCTJrRUoa9xUgIVi+7u77E3eRuFAHo
 YcMYHqbTtdeHe3uzw8CjGVyh82B9hq/f6LAaWe580n2hAnvGCamZDEjZ31eExoaAGy
 QfwhUDWnhRLlTZcUefojgMV0Q3oWfb7cn5SQhSOs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0M9vnQ-1i6Wpj33HM-00B20h; Tue, 20
 Aug 2019 04:39:28 +0200
Subject: Re: [PATCH] erofs: move erofs out of staging
To: Chao Yu <yuchao0@huawei.com>, Gao Xiang <hsiangkao@aol.com>,
 "Darrick J. Wong" <darrick.wong@oracle.com>
References: <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
 <20190818151154.GA32157@mit.edu> <20190818155812.GB13230@infradead.org>
 <20190818161638.GE1118@sol.localdomain>
 <20190818162201.GA16269@infradead.org>
 <20190818172938.GA14413@sol.localdomain>
 <20190818174702.GA17633@infradead.org>
 <20190818181654.GA1617@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190818201405.GA27398@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190819160923.GG15198@magnolia>
 <20190819203051.GA10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <bdb91cbf-985b-5a2c-6019-560b79739431@gmx.com>
 <ad62636f-ef1b-739f-42cc-28d9d7ed86da@huawei.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <c6f6de48-2594-05e4-2048-9a9c59c018d7@gmx.com>
Date: Tue, 20 Aug 2019 10:38:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ad62636f-ef1b-739f-42cc-28d9d7ed86da@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZcFaNUhdca516snD5gfrUpiGczpht7Jwk"
X-Provags-ID: V03:K1:c2p9VE+Oz1e5Qk9cae6kGxHfsuxDqRoZQNqi3EJlrAqBTozsbkj
 RBlyMfdf/CJR7aYqVvyczkHFhBenXqnIl54ITMgffRqrmjguV9f1rwyiGQg9XP/1f9QB8DL
 6kO0WCpSIuvb5IXUitktI/HUH005hVbc4xLcdSlr08IU+eFpzuTPGLQ0qSk1/CTJj0Bl7R3
 C0D4qu9/jbiVAAwN49EVg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lzzSWcXf65w=:S8/HzCQ/kG6SrF5VmqmwBR
 J50nnpDqWMoKOpEr/iWNqF4FyaILfKWOBioJtyrkp1ck69aYRngUrgpdj1Se9huyv9V+LTMlO
 8PpScOiedwft0PRz819EA3k9NQUOVFtMaLC/IQqqQzQD2huJ3ZMe0Lz0c9kK6fHn7t5VpQNI4
 VS6EJvfjUHD3uohH5rAfjbjUplgzJ6IvZ6Lmxx5FAOSxletm+zTQUaypuyMbYioD9F44+96jF
 HilZJOu6yNN1cZvtPbz8S4KWn1jiZ71Alq9pkT+pZSgiJbelfcH4wXC/3mLHPMAtD5H2SfN+q
 4KRy5jFvJ1c0b6YZVWZ90Ikgz22i6VcTWMQcAIwktlkb1rP19kcWwQe/3bW7PKROZ6mImGcLM
 SfpkWrlkWON8rMUTO7lBiibokA6l5ff8MujSASdhkTCcjQJSk/WtYgcrv+e/wMrW8tcaHiuDW
 IpKFmdisbpEhD8sSMkJ4tJZgHBAsB7IN7+jLbTaSVPOVypgLRFZKJ4k7hpuXtbl8jgBwZFJrV
 Lzy4sli+vlflYmS2XvLwF5I/I3zH5s9EDGMQi2HLy/zhC6KgTi47ZvdBplM2ny5oPXGDqvdHJ
 2Sd/2IBGXkYLBerO0A20Z15H731U/7EkImpiDgMYW5jJHNPYsMWnFtJakMieaLBLL4aATyXOE
 kTHWezSBXJLNSfRUPxaCAQvx+7Ba/FDFZ/FW6i53qDT6+14jizjfKrADlfG3VkjzOCpYyTu9L
 JdJyBBRIeWCo7Nn8esfdK1SGQTRe++ps1Ha1bpTDoC4Eve83Y1yoZVPUacu4XWTKk7jjRGkR9
 bHjki0resBikQhWdi5hQ/07fT54UGfJxBs00c4sRPtTF8uO429+K6XchOtS+ps37XvBON5cWZ
 /r0oDcWdzIJe13FtsJeDNlR1e9mGJHSNWWgDd4yaRdDDjk+E6SMRSr1cjCtnFTowciKVy8p2w
 iLq4WdGc7OGvW+VRlehKR7q02bKxt0IhqASAwAHd2c3ls4nTh/veWvF3Lgu7ry0lFun+01A5w
 E7/k1KM4hjS5EklZ9FuyX4HCQLrhoElwne/swoI6injLfxGtP211dzTF5RCrCEwws1HVMns2G
 +pStcIc7bDJm/FBEragtG0Nan/qsRdHfe1REd5nsIJ7oYWkJ8Ns9WMS/A==
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
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
 Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
 devel <devel@driverdev.osuosl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Richard Weinberger <richard@nod.at>, Eric Biggers <ebiggers@kernel.org>,
 torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Sterba <dsterba@suse.cz>, Pavel Machek <pavel@denx.de>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZcFaNUhdca516snD5gfrUpiGczpht7Jwk
Content-Type: multipart/mixed; boundary="KOLhSQdbj64o9tSdc1Tfy4Jf4WtOuzKjP";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Chao Yu <yuchao0@huawei.com>, Gao Xiang <hsiangkao@aol.com>,
 "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, "Theodore Y. Ts'o"
 <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>,
 Richard Weinberger <richard@nod.at>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>,
 Dave Chinner <david@fromorbit.com>, David Sterba <dsterba@suse.cz>,
 Miao Xie <miaoxie@huawei.com>, devel <devel@driverdev.osuosl.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Amir Goldstein
 <amir73il@gmail.com>, linux-erofs <linux-erofs@lists.ozlabs.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>,
 Pavel Machek <pavel@denx.de>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 torvalds <torvalds@linux-foundation.org>
Message-ID: <c6f6de48-2594-05e4-2048-9a9c59c018d7@gmx.com>
Subject: Re: [PATCH] erofs: move erofs out of staging
References: <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
 <20190818151154.GA32157@mit.edu> <20190818155812.GB13230@infradead.org>
 <20190818161638.GE1118@sol.localdomain>
 <20190818162201.GA16269@infradead.org>
 <20190818172938.GA14413@sol.localdomain>
 <20190818174702.GA17633@infradead.org>
 <20190818181654.GA1617@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190818201405.GA27398@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190819160923.GG15198@magnolia>
 <20190819203051.GA10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <bdb91cbf-985b-5a2c-6019-560b79739431@gmx.com>
 <ad62636f-ef1b-739f-42cc-28d9d7ed86da@huawei.com>
In-Reply-To: <ad62636f-ef1b-739f-42cc-28d9d7ed86da@huawei.com>

--KOLhSQdbj64o9tSdc1Tfy4Jf4WtOuzKjP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/20 =E4=B8=8A=E5=8D=8810:24, Chao Yu wrote:
> On 2019/8/20 8:55, Qu Wenruo wrote:
>> [...]
>>>>> I have made a simple fuzzer to inject messy in inode metadata,
>>>>> dir data, compressed indexes and super block,
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.g=
it/commit/?h=3Dexperimental-fuzzer
>>>>>
>>>>> I am testing with some given dirs and the following script.
>>>>> Does it look reasonable?
>>>>>
>>>>> # !/bin/bash
>>>>>
>>>>> mkdir -p mntdir
>>>>>
>>>>> for ((i=3D0; i<1000; ++i)); do
>>>>> 	mkfs/mkfs.erofs -F$i testdir_fsl.fuzz.img testdir_fsl > /dev/null =
2>&1
>>>>
>>>> mkfs fuzzes the image? Er....
>>>
>>> Thanks for your reply.
>>>
>>> First, This is just the first step of erofs fuzzer I wrote yesterday =
night...
>>>
>>>>
>>>> Over in XFS land we have an xfs debugging tool (xfs_db) that knows h=
ow
>>>> to dump (and write!) most every field of every metadata type.  This
>>>> makes it fairly easy to write systematic level 0 fuzzing tests that
>>>> check how well the filesystem reacts to garbage data (zeroing,
>>>> randomizing, oneing, adding and subtracting small integers) in a fie=
ld.
>>>> (It also knows how to trash entire blocks.)
>>
>> The same tool exists for btrfs, although lacks the write ability, but
>> that dump is more comprehensive and a great tool to learn the on-disk
>> format.
>>
>>
>> And for the fuzzing defending part, just a few kernel releases ago,
>> there is none for btrfs, and now we have a full static verification
>> layer to cover (almost) all on-disk data at read and write time.
>> (Along with enhanced runtime check)
>>
>> We have covered from vague values inside tree blocks and invalid/missi=
ng
>> cross-ref find at runtime.
>>
>> Currently the two layered check works pretty fine (well, sometimes too=

>> good to detect older, improper behaved kernel).
>> - Tree blocks with vague data just get rejected by verification layer
>>   So that all members should fit on-disk format, from alignment to
>>   generation to inode mode.
>>
>>   The error will trigger a good enough (TM) error message for develope=
r
>>   to read, and if we have other copies, we retry other copies just as
>>   we hit a bad copy.
>>
>> - At runtime, we have much less to check
>>   Only cross-ref related things can be wrong now. since everything
>>   inside a single tree block has already be checked.
>>
>> In fact, from my respect of view, such read time check should be there=

>> from the very beginning.
>> It acts kinda of a on-disk format spec. (In fact, by implementing the
>> verification layer itself, it already exposes a lot of btrfs design
>> trade-offs)
>>
>> Even for a fs as complex (buggy) as btrfs, we only take 1K lines to
>> implement the verification layer.
>> So I'd like to see every new mainlined fs to have such ability.
>=20
> Out of curiosity, it looks like every mainstream filesystem has its own=

> fuzz/injection tool in their tool-set, if it's really such a generic
> requirement, why shouldn't there be a common tool to handle that, let s=
pecified
> filesystem fill the tool's callback to seek a node/block and supported =
fields
> can be fuzzed in inode.

It could be possible for XFS/EXT* to share the same infrastructure
without much hassle.
(If not considering external journal)

But for btrfs, it's like a regular fs on a super large dm-linear, which
further builds its chunks on different dm-raid1/dm-linear/dm-raid56.

So not sure if it's possible for btrfs, as it contains its logical
address layer bytenr (the most common one) along with per-chunk physical
mapping bytenr (in another tree).

It may depends on the granularity. But definitely a good idea to do so
in a generic way.
Currently we depend on super kind student developers/reporters on such
fuzzed images, and developers sometimes get inspired by real world
corruption (or his/her mood) to add some valid but hard-to-hit corner
case check.

Thanks,
Qu

> It can help to avoid redundant work whenever Linux
> welcomes a new filesystem....
>=20
> Thanks,
>=20
>>
>>>
>>> Actually, compared with XFS, EROFS has rather simple on-disk format.
>>> What we inject one time is quite deterministic.
>>>
>>> The first step just purposely writes some random fuzzed data to
>>> the base inode metadata, compressed indexes, or dir data field
>>> (one round one field) to make it validity and coverability.
>>>
>>>>
>>>> You might want to write such a debugging tool for erofs so that you =
can
>>>> take apart crashed images to get a better idea of what went wrong, a=
nd
>>>> to write easy fuzzing tests.
>>>
>>> Yes, we will do such a debugging tool of course. Actually Li Guifu is=
 now
>>> developping a erofs-fuse to support old linux versions or other OSes =
for
>>> archiveing only use, we will base on that code to develop a better fu=
zzer
>>> tool as well.
>>
>> Personally speaking, debugging tool is way more important than a runni=
ng
>> kernel module/fuse.
>> It's human trying to write the code, most of time is spent educating
>> code readers, thus debugging tool is way more important than dead cold=
 code.
>>
>> Thanks,
>> Qu
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>>
>>>> --D
>>>>
>>>>> 	umount mntdir
>>>>> 	mount -t erofs -o loop testdir_fsl.fuzz.img mntdir
>>>>> 	for j in `find mntdir -type f`; do
>>>>> 		md5sum $j > /dev/null
>>>>> 	done
>>>>> done
>>>>>
>>>>> Thanks,
>>>>> Gao Xiang
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Gao Xiang
>>>>>>
>>


--KOLhSQdbj64o9tSdc1Tfy4Jf4WtOuzKjP--

--ZcFaNUhdca516snD5gfrUpiGczpht7Jwk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1bXUAACgkQwj2R86El
/qjkEAf/VTTYOgUl4tgxaElwD2C7rGAHcRYrpcwv9PjSrWg84AQX+xrkZP0sJORB
LakpTHdqA/18MdWz5gIZUtxsSxylPL6Uyj5CPKGoNl8sjIz0tuvN85iv1zzC+nrA
H8CMwH/LJzfnG+35fSmc5B0l1mndGYJJsF90nndbjHvHBvGJ+F78LYnexV4/KAgM
9fECezanTTdL8dUmHsfQGd0dSiFoxs6qSXcumMvJuHjQoxAJXvHc8BXr2k2f9V/C
M6FEc98KgXUq5QW9Ak9vRoizH62sIKBFEmBUlXJKzfgxmOC+gTjwlM478n3g4J90
P9LVZkt+/5zj2dtV5XbuGCoIM2jY1A==
=0v8N
-----END PGP SIGNATURE-----

--ZcFaNUhdca516snD5gfrUpiGczpht7Jwk--
