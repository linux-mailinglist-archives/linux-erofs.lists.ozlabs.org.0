Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1292658B280
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Aug 2022 00:50:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M015V0qk3z2xTb
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Aug 2022 08:50:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256 header.s=badeba3b8450 header.b=NstD5NjO;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmx.com (client-ip=212.227.17.22; helo=mout.gmx.net; envelope-from=quwenruo.btrfs@gmx.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256 header.s=badeba3b8450 header.b=NstD5NjO;
	dkim-atps=neutral
X-Greylist: delayed 314 seconds by postgrey-1.36 at boromir; Sat, 06 Aug 2022 08:50:14 AEST
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M015L2fgMz2xGt
	for <linux-erofs@lists.ozlabs.org>; Sat,  6 Aug 2022 08:50:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1659739809;
	bh=EZDEeLHDCHT05JeDxPkGDFiOONLqP3koUfqpjxms1WM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NstD5NjOQ3gn93cSsAJ9rE6376d+TWVdpKSNbS5QFplyP7SL79RnaM066PXfh2efP
	 5/souv5AT90jEy/3MaGltCtebQmhj4POWqXv5M5S1KxeIuZNBmwb92HUjYElJtyNgL
	 1AVvge/Rmi8AlUeUSzOWgnBY/bDbOCqxTIYMDSnc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUowb-1ntWdI0ICn-00Qmu2; Sat, 06
 Aug 2022 00:44:45 +0200
Message-ID: <99d73f60-868c-28e9-e862-04a934e741ef@gmx.com>
Date: Sat, 6 Aug 2022 06:44:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/8] fs: fat: unexport file_fat_read_at()
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Qu Wenruo <wqu@suse.com>
References: <cover.1658812744.git.wqu@suse.com>
 <ee01c16f20f02230c3cfd0b266f06564fa211f62.1658812744.git.wqu@suse.com>
 <20220805211420.GA3027583@bill-the-cat>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220805211420.GA3027583@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6fHU6tg0nJ2s08uFblW8t60l1ohZpMVr6Bpr4V00P/yhoCy5qfS
 SzIPnQkUcphor7fCrVjeZFBqSvtSsr7TmWci1SKkU1C27wdXxZhkVXsj8C5WjKPbC2l3YCh
 iXokM+iF/M0I0MbQ7mCkSmkXEEKJKe4uKcXvhAORBi93zFNJked1jzLcW8e4Gn7s3MPAvq5
 q4x8/uStHaGoQ3Qq7MpyQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S54L+Qbbb9s=:vl5R52e23vj9Wyi0O1NU33
 ETLlDXIocH/dNX0EJy38akC+DMCuOIudhWhtRHRjyys9oj2pATaqpfcqeKeJ3V5Rty2699NZS
 +HylrZnFUUCkfOnCSEkKPSSRBzGGHTpEqXBxYlnvvAXmDqDtzhs++QUjQB4yYJ6vvr9e0RtOF
 bytgpxnUP6g1uVrq/x8iRZjbu9ujm7KLT5sjzOB3zNjPwDB5l+n0roDiQK/UAgC/ZGo7RzAhB
 vlnIhDd+y71+N5fzsZkTlnC9NsSrxE7qEY84LoOwSrw2HVuq3mbt+ngj6T+Yknn+EkMov+vmz
 XunfM7BrWloJqN4ncOwcp5/Z/ZvwVkdGWP6jdHz5bVs9TJWQpq2ScH1htudmLnOoJ4uEV9TLL
 VYrAZF5mwFtkwCX7lDeOukmbC3+kv7m7sv34IHWtJbK1wrrqtIUDTk7XRE0fqEneWceYrGjwp
 s5UZb+UmQgQTxp/ufelIS6d20Di5So8+IcBheX0Sd6g1+IbWURU2B/kTLADt5ZqWiR/8AZW/g
 HALvlP3Gju+6U7RxmFzqdy/38ZHK3weMGaGhiPfmPKTiVfgq2jqzTwwD1x6iGya3n43QcX9RQ
 O9fPKKXbJJbdyZGGFsijxrDA3KVfkbGlLgsfYb/RBIKM2wksy354jrtMf2NmYo/96jx2xB5qW
 ukzyOAg8hp82Yw1JuQANbcfGhAdtaU2x0hhr2ZJQ2PAowr9PnpSmFfi7YyAwzjTPHo0noQnzc
 SLSY3dKdArN4LUTjqy7K0p5nrPle2m6ns4zWnztgz4aq9lH35Xxye0nNvR9m3T89o0QW0HSji
 i1BsNXwGYzeDAIqZzMhH5O3P68kA1zh/SIe+6cG9fU5ywBGvp1MRyEXZ+io+oKGBtTlCOK/HQ
 SltCG9UDgOy6i3QjF413/d6EsmY7ZPETqWFuRFuoWckqqUqc+v7xKplozndm1o0W7c8cwjkw1
 XY5hoy5Ri64h9hB+Mna9OLB+9liAGH5et4JNJSun9eAaSQDs0hx7cJiCFrowtNlJT/xDS2ssJ
 ICEM66OTkU+SwI+CsJf19qFkwn5lFHCyOCPwLUlD6lFZWJ+PwFQ8m00oKrQC/aAeWOZzdvXAO
 tW8RJYLV0KCti5/hzLsaAmxYKdvgfbff5wLgT2hy4h9dFaWTVXh+SAMtw==
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
Cc: joaomarcos.costa@bootlin.com, marek.behun@nic.cz, u-boot@lists.denx.de, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2022/8/6 05:14, Tom Rini wrote:
> On Tue, Jul 26, 2022 at 01:22:09PM +0800, Qu Wenruo wrote:
>
>> That function is only utilized inside fat driver, unexport it.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Unfortunately, the series fails CI:
> https://source.denx.de/u-boot/u-boot/-/jobs/478838
>

OK, it's a bug in the unsupported fses (which squashfs doesn't support)

The actual read bytes is not updated.

Sorry for the inconvenience.

Any idea that how to run the full tests locally so I can prevent such
problem?

Thanks,
Qu
