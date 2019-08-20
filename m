Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D072952F0
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2019 03:03:34 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46CCGW696SzDqg6
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2019 11:03:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.com
 (client-ip=212.227.15.18; helo=mout.gmx.net;
 envelope-from=quwenruo.btrfs@gmx.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=gmx.net header.i=@gmx.net header.b="T1792Cjy"; 
 dkim-atps=neutral
X-Greylist: delayed 379 seconds by postgrey-1.36 at bilbo;
 Tue, 20 Aug 2019 11:03:22 AEST
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46CCGL5WGxzDqHf
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2019 11:03:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1566262989;
 bh=k2K6YSTlIajPTv2Lr/mNkZv9MUudny3z0bMOKTfBl30=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=T1792Cjy3RSobgLuf+TJEjaO9p1Xl2h6CpzdaYu+BL8FiIINiapzv3wT970TEii7z
 PfOGItI4z4TH6zs4bDXIPii6Nz8/2dENdb3Fy2+UkIrY73Mp45/Lt6ZIRrpD4OWdwB
 UeqZdpRrCUz8M7uRveG7k62FB4YGrxRPeh7k0bE8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MaJ3n-1hnTrR1IoP-00WGtm; Tue, 20
 Aug 2019 02:55:59 +0200
Subject: Re: [PATCH] erofs: move erofs out of staging
To: Gao Xiang <hsiangkao@aol.com>, "Darrick J. Wong" <darrick.wong@oracle.com>
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
Message-ID: <bdb91cbf-985b-5a2c-6019-560b79739431@gmx.com>
Date: Tue, 20 Aug 2019 08:55:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819203051.GA10075@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kc20TgGuw6sblKpmXo42EZMsKU6JoI52i"
X-Provags-ID: V03:K1:1DoALE6zLp0BOjDrRvwy8lSZ78vFXbxR00FDlf85TiEYMJ9fRzv
 6XSuXy6TmrRMX7d/lNibdo5X5dUYyxkSBc6XMnJ7CaywKHdYExKQwhCFSyi6RyWf41+ewyo
 jJPPRPhsfiT1Lhu2RVbRNg6dZskH+Z2OoECWBUs92KASIdG8hnoKSI1mqdHX8p7cGr80K7u
 TeKo+oN2AE01pQVBp2SFA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:to5sDtZ1O9c=:IlZBOVaBTk2BB3z8rKQZEu
 s7u5aOoo16KF825O//mtqtp6Brs5DhFjdYxOw3W+Sshy9uDB6Swhk4kFwwIs2ioqRXXnkmYU/
 fiT1iJuPrO8Uf3QsdYWMfaqZeWbakg9NsmXVXxdbz/Zb9ZDsIpvWN22Pj2tdDuWdcnDkCFVF2
 isIqJ5+dgvRIlTg5ZVmsXhRdXRpzbQboEoHa6udRKzWnQ/hZhNmR9cAPfigL2JjSR7bO0muqj
 eapfmhdl71/WVmm5PuzS84/NGZj048DkgJlyUIDR6llqjT049ZFmVY3LzANtfOOOul8jf8hSB
 NCQny9Pg49zfY7ayUxtBA5h5cmvzMKLXKXKE4Oxkmz7gEcBZMhtcV7mYDXBosvbCHwxxK2/AW
 nLa8YnaxQZinXlhk5XRcZ6bJ/8YVP4QmfYMBeqBRhbuckWmSGlPdBSdSZ9+WKGpJEDeJYXy3t
 YSjUx86sAO3ebqyON0HEwkQtpFK9X/DZZMvlXhd4lwUVSL7fdHtKFfEiqUYxphH9lda9d1qcK
 6l0Dgkwxp+WhoGLkfn4xWLLM3PvxHpTDUgl0cBXsaAGRoGWGU9ndK4NYLJqvScZVAOUIHdKqD
 gzNu9Tlbav6SwicIoP+liGv6Qg28LMImOPPLB4lj78HdZzN4hB40iwE6virokRTUgi3spiOaC
 59RpeC68Sk/bJE/nCt0+gO6ON5wGpI5qh4b0Y9uJId4C5oxFrrAWghwgpiuwase2t3UibBuDX
 h6VorS+LxyZxp+yN3BMmEKQ+XriFjMz+hN0TWzSH4VsTYZMkDe6Y9fCfFlKG/A4WKrfAYMGU0
 a3W1OpUshhrB1bWMMpXD5Rzkb4bq9ZDHDPg/0bl1Tf4r6FHCrvQaWDab+jQQ16306k9DqcSUx
 BjWV0KC/8LARIjuomfKnOKjh3vCybO6wIbuVfpboZv4bDfP4eJY+hjAXpeCNgllHkY3fnblpm
 IF7VbWbuKfjZj/A7+od25fC1cYneu1zPRz8Jwn6rtfd8GDR9FZIDOay9eyGJhrv1wMiWxfuKR
 2ZQf+ps+tyrkgpjNnOmu+sTIThOeOqL8mjBW1sG4sRst5yu14t6m9lSELycSvb6cMUVprIzAs
 Lh3Jb0iGP0EJ1HDgXT1Rw8aRBxQYNz3EzK1XrtocpP4xdMY3FPlNrCZoAnyv/BUSK+Vhj0B0M
 SweCrzwhgQGjsqxldRCFP02LyI9HRSZEIoihTyNA6GNnJjdQ==
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
--kc20TgGuw6sblKpmXo42EZMsKU6JoI52i
Content-Type: multipart/mixed; boundary="fjK6tUAQaCcRZsGhn3Ra1ToeeOFPMFrfF";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Gao Xiang <hsiangkao@aol.com>, "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, "Theodore Y. Ts'o"
 <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>,
 Richard Weinberger <richard@nod.at>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>,
 Chao Yu <yuchao0@huawei.com>, Dave Chinner <david@fromorbit.com>,
 David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
 devel <devel@driverdev.osuosl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Amir Goldstein <amir73il@gmail.com>,
 linux-erofs <linux-erofs@lists.ozlabs.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>,
 Pavel Machek <pavel@denx.de>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 torvalds <torvalds@linux-foundation.org>
Message-ID: <bdb91cbf-985b-5a2c-6019-560b79739431@gmx.com>
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
In-Reply-To: <20190819203051.GA10075@hsiangkao-HP-ZHAN-66-Pro-G1>

--fjK6tUAQaCcRZsGhn3Ra1ToeeOFPMFrfF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

[...]
>>> I have made a simple fuzzer to inject messy in inode metadata,
>>> dir data, compressed indexes and super block,
>>> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git=
/commit/?h=3Dexperimental-fuzzer
>>>
>>> I am testing with some given dirs and the following script.
>>> Does it look reasonable?
>>>
>>> # !/bin/bash
>>>
>>> mkdir -p mntdir
>>>
>>> for ((i=3D0; i<1000; ++i)); do
>>> 	mkfs/mkfs.erofs -F$i testdir_fsl.fuzz.img testdir_fsl > /dev/null 2>=
&1
>>
>> mkfs fuzzes the image? Er....
>=20
> Thanks for your reply.
>=20
> First, This is just the first step of erofs fuzzer I wrote yesterday ni=
ght...
>=20
>>
>> Over in XFS land we have an xfs debugging tool (xfs_db) that knows how=

>> to dump (and write!) most every field of every metadata type.  This
>> makes it fairly easy to write systematic level 0 fuzzing tests that
>> check how well the filesystem reacts to garbage data (zeroing,
>> randomizing, oneing, adding and subtracting small integers) in a field=
=2E
>> (It also knows how to trash entire blocks.)

The same tool exists for btrfs, although lacks the write ability, but
that dump is more comprehensive and a great tool to learn the on-disk
format.


And for the fuzzing defending part, just a few kernel releases ago,
there is none for btrfs, and now we have a full static verification
layer to cover (almost) all on-disk data at read and write time.
(Along with enhanced runtime check)

We have covered from vague values inside tree blocks and invalid/missing
cross-ref find at runtime.

Currently the two layered check works pretty fine (well, sometimes too
good to detect older, improper behaved kernel).
- Tree blocks with vague data just get rejected by verification layer
  So that all members should fit on-disk format, from alignment to
  generation to inode mode.

  The error will trigger a good enough (TM) error message for developer
  to read, and if we have other copies, we retry other copies just as
  we hit a bad copy.

- At runtime, we have much less to check
  Only cross-ref related things can be wrong now. since everything
  inside a single tree block has already be checked.

In fact, from my respect of view, such read time check should be there
from the very beginning.
It acts kinda of a on-disk format spec. (In fact, by implementing the
verification layer itself, it already exposes a lot of btrfs design
trade-offs)

Even for a fs as complex (buggy) as btrfs, we only take 1K lines to
implement the verification layer.
So I'd like to see every new mainlined fs to have such ability.

>=20
> Actually, compared with XFS, EROFS has rather simple on-disk format.
> What we inject one time is quite deterministic.
>=20
> The first step just purposely writes some random fuzzed data to
> the base inode metadata, compressed indexes, or dir data field
> (one round one field) to make it validity and coverability.
>=20
>>
>> You might want to write such a debugging tool for erofs so that you ca=
n
>> take apart crashed images to get a better idea of what went wrong, and=

>> to write easy fuzzing tests.
>=20
> Yes, we will do such a debugging tool of course. Actually Li Guifu is n=
ow
> developping a erofs-fuse to support old linux versions or other OSes fo=
r
> archiveing only use, we will base on that code to develop a better fuzz=
er
> tool as well.

Personally speaking, debugging tool is way more important than a running
kernel module/fuse.
It's human trying to write the code, most of time is spent educating
code readers, thus debugging tool is way more important than dead cold co=
de.

Thanks,
Qu
>=20
> Thanks,
> Gao Xiang
>=20
>>
>> --D
>>
>>> 	umount mntdir
>>> 	mount -t erofs -o loop testdir_fsl.fuzz.img mntdir
>>> 	for j in `find mntdir -type f`; do
>>> 		md5sum $j > /dev/null
>>> 	done
>>> done
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>>
>>>> Thanks,
>>>> Gao Xiang
>>>>


--fjK6tUAQaCcRZsGhn3Ra1ToeeOFPMFrfF--

--kc20TgGuw6sblKpmXo42EZMsKU6JoI52i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1bRQQACgkQwj2R86El
/qj2cwf9ElVncfkkFaQj51k9ujZukPC9oqBVE8mfeOLjhEOCT5xPdPXvMY5BXtln
OFTFnouVpBanQEXFpiTCh3JIyFWzsMQJ136GEsWGZ0KOklgLtlDUrl1xPAlRRkvg
+Z5CL0BO3ujxeLxhRJWyRNHypE7tzKIPhM/k/9Od/4zzpuQpgS09GqFtINhlO7Ub
ftY5FpJngDfPMAfh7EPqZcRcT7q4A6PRME5sVQDPiTiivdExliODTDC4HkVi9O4Z
UPGsHQnZmyJM7r14FFmguIL3UMmwOpXfL8uKy8Enb0Kl+tNFxRwNbBGXVQZP2wSG
QOiJjuO9VFuuY0PIlIQmpY/Pdakx9g==
=WMVP
-----END PGP SIGNATURE-----

--kc20TgGuw6sblKpmXo42EZMsKU6JoI52i--
