Return-Path: <linux-erofs+bounces-690-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 52072B0C380
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Jul 2025 13:44:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blz7g0jG4z2xS2;
	Mon, 21 Jul 2025 21:43:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753098239;
	cv=none; b=EdVpPGYVbYuNnRCh3m+9oqB0ctFN0PHn8mee/xxNJSNc4XrkdVQSUIiYp1v0Nng/C5p5dI+iZJAvDQxi5ZC9OwW3Jk0bxJU1UuZP56v+u6uAUQpTmLb0RWAKxRhyxZikXa8QvbdvPM9kFOi/8RHQt0nGmTx3LZhPm6y2vZP+KPnYzZp1V3yzuPLrTxxEbXpNBawnHsODBjm3AfC478JMwrjJ4duXePWj18FW6HIvQ5JC1eJW+qCekbVyHqmAmsUJo2ohoJY4nb9rTmsWrIVjCToYDOh2P5TRDWOKsJJsM30AA6RxVwln2NyGHaTD65L9MHFCKWFua4r0wKxTXpp9Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753098239; c=relaxed/relaxed;
	bh=zBIsLLD0agXGs83w4tbKBYZqttgfplGTbcXLQzdNcrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPrXnuYw4hwwRjaNPqJ3rzLLxM2Vdw1iABHPfKtV0xi9PVvAgeZC58f8EhI9hhoDbZfNqeQ6ZTDN71zHq+8AtN+wPSwUPOvSGiin0fRVDo3h8gr6bslkvy8yGtN6XZcqOf5nCwLniw+62RHX2GwjSA4u/IscDundNapq9hJneBum9wS71rnWHpl7qiUBfAe9UsCHaGMySzulFCk8l/UUzub1YVwNGyr9t51WSRgP5+zRayLr41RtP+XZIYpWcUEDS57bW+JAfuji4PcDjPhTHfSyzV0cNfG+VcJXRjV0cWAoS0AQOIVOaKwkmFD0fByWmRtARL2ZtFw4ucGmzHvAEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; dkim=pass (2048-bit key; secure) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.a=rsa-sha256 header.s=s31663417 header.b=eMaOSLmJ; dkim-atps=neutral; spf=pass (client-ip=212.227.15.19; helo=mout.gmx.net; envelope-from=quwenruo.btrfs@gmx.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmx.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.a=rsa-sha256 header.s=s31663417 header.b=eMaOSLmJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmx.com (client-ip=212.227.15.19; helo=mout.gmx.net; envelope-from=quwenruo.btrfs@gmx.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 354 seconds by postgrey-1.37 at boromir; Mon, 21 Jul 2025 21:43:56 AEST
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blz7c2vw3z2xHY
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Jul 2025 21:43:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1753098233; x=1753703033; i=quwenruo.btrfs@gmx.com;
	bh=zBIsLLD0agXGs83w4tbKBYZqttgfplGTbcXLQzdNcrg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eMaOSLmJi9W820v3UzNoZaqObVMkUNYNcJCAPcXryax0Y9dATFnBhm6rpOnZy/eE
	 AT2n5I2QRp1KSrK1cjnccqn8FFWZxiZaR7ExNEdhH8+CTIoJROEpNL1EyOrK0M5a3
	 6nfsFWQxh0rCAkLNTrpL3mYqpKRfJGAwUTjrksi/+RlFhhufvelqr+M975rbk7QA/
	 nt2lREi6Qc44UJ2BJzPDvW6WOOm9I0/H0HHO6yMJntfncSrFDONMjq+QfA8NvKkgi
	 1PNKAwAWxTTbLnT44X+tiBXt5NM2p4XIhdrIE523/brjsPbNzyrxp1pl7qOU/Vz8/
	 0dOMRLhcdV0oHw1IUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MybGh-1uoDpm0wnN-010ycz; Mon, 21
 Jul 2025 13:36:51 +0200
Message-ID: <85946346-8bfd-4164-a49d-594b4a158588@gmx.com>
Date: Mon, 21 Jul 2025 21:06:38 +0930
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
User-Agent: Mozilla Thunderbird
Subject: Re: Compressed files & the page cache
To: Jan Kara <jack@suse.cz>, Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Barry Song <21cnbao@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
 David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
 Paulo Alcantara <pc@manguebit.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
 linux-cifs@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>,
 Hailong Liu <hailong.liu@oppo.com>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
 <b61c4b7f-4bb1-4551-91ba-a0e0ffd19e75@linux.alibaba.com>
 <CAGsJ_4xJjwsvMpeBV-QZFoSznqhiNSFtJu9k6da_T-T-a6VwNw@mail.gmail.com>
 <7ea73f49-df4b-4f88-8b23-c917b4a9bd8a@linux.alibaba.com>
 <z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KDXt1vR1fT3Zmk9s0ZPAImsaPPiOo0tezqUWd5Kf9CdjbZbF7k4
 k3gVPpxoDBzZaxV6R+UYdLWaK1/PTnGXVRZ1s6k8AUc3RGswW9CCDD2U/eWO9Hwv8oYpkYI
 THIoD2qPA/NKqeH2x5OB4BeuIqWMGlXiYNhqMnFs75vdCpTKJCpG82FqfbLeMe6qpgbYlsV
 LdrTRCbJ1pA9hGbTaSpcQ==
UI-OutboundReport: notjunk:1;M01:P0:S3f0+uglp8k=;8Zqx9Xm/cz7ez6Z876VNe1pKtRB
 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
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



=E5=9C=A8 2025/7/21 19:55, Jan Kara =E5=86=99=E9=81=93:
> On Mon 21-07-25 11:14:02, Gao Xiang wrote:
>> Hi Barry,
>>
>> On 2025/7/21 09:02, Barry Song wrote:
>>> On Wed, Jul 16, 2025 at 8:28=E2=80=AFAM Gao Xiang <hsiangkao@linux.ali=
baba.com> wrote:
[...]
>>> Given the difficulty of allocating large folios, it's always a good
>>> idea to have order-0 as a fallback. While I agree with your point,
>>> I have a slightly different perspective =E2=80=94 enabling large folio=
s for
>>> those devices might be beneficial, but the maximum order should
>>> remain small. I'm referring to "small" large folios.
>>
>> Yeah, agreed. Having a way to limit the maximum order for those small
>> devices (rather than disabling it completely) would be helpful.  At
>> least "small" large folios could still provide benefits when memory
>> pressure is light.
>=20
> Well, in the page cache you can tune not only the minimum but also the
> maximum order of a folio being allocated for each inode. Btrfs and ext4
> already use this functionality. So in principle the functionality is the=
re,
> it is "just" a question of proper user interfaces or automatic logic to
> tune this limit.
>=20
> 								Honza

And enabling large folios doesn't mean all fs operations will grab an=20
unnecessarily large folio.

For buffered write, all those filesystem will only try to get folios as=20
large as necessary, not overly large.

This means if the user space program is always doing buffered IO in a=20
power-of-two unit (and aligned offset of course), the folio size will=20
match the buffer size perfectly (if we have enough memory).

So for properly aligned buffered writes, large folios won't really cause=
=20
  unnecessarily large folios, meanwhile brings all the benefits.


Although I'm not familiar enough with filemap to comment on folio read=20
and readahead...

Thanks,
Qu

