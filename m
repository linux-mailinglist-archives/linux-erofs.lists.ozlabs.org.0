Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F97A135D7
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 09:49:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYc4R1W3mz3c6n
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 19:49:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=18.169.211.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737017381;
	cv=none; b=ggpLnqSsK8+y7VXwoKHckuHeBlcboVsWW/4sql4vSoxTrCL4XM5diM1ENNKVVj1pl3C6Tc5vT8Tqaur43VOmXpr3nfwryjGCxIYwkdM0/h1htCu4xHpqzpuKppzndzKUSt09gEzZ5rBa5nraaTzoaNp8K/F8F8la5hcuv24ff63vkXwVFnERGONAFQOHfDvYks+F0lrCaiPhfMY2I2u1sJ4zykX6FlGihzG2CoNVhvU95IuIdzsM9T9OLqQ5aEbzccztCBdeFwM6zuAudt2TJ5BEJ4QuCv+UfLcoifY4S+TOxP/cfeGimxkQXvChtLifWQvTu6InM4tMj2kQDjLoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737017381; c=relaxed/relaxed;
	bh=BTSJJ9dN2c7B+4kzb4OwUDBrwMiBS+3wBlh03ZbeyeE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hhJw0uFyi0KQ/epNdVlTFoRMFj9j19/tZYmzICYk5qY2V/+5qiYZsePdB/27gWBQA/mxFG995vQGgzFTRVqv64KT92x3Yej42hLPO5ho8o9YVAu5fmMPgdRtA3J5X/gPKMdMF8CZKl+oCdZCZKBSLkcJASE6SYbaqM08h4iu8KuqIoll8Iau3ciDkoz3GU2UEiTliUVSLUu15OFcWGU5Yq3/TSKqhwXZi/Ei0s8MvTRHRH0pfhvGtFiGNgr/miAr7tJcScZrr8splr9Se0ZYgEZK36KFF/xML3v+ntsP09QT/j349uV5y6kO4z45b75W+Fr/muRLLNCfFsuWmaJ0pQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=KyAfrHb4; dkim-atps=neutral; spf=pass (client-ip=18.169.211.239; helo=smtpbg151.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=KyAfrHb4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=18.169.211.239; helo=smtpbg151.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 746 seconds by postgrey-1.37 at boromir; Thu, 16 Jan 2025 19:49:38 AEDT
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYc4L0x2Dz2yvl
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 19:49:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1737017321;
	bh=BTSJJ9dN2c7B+4kzb4OwUDBrwMiBS+3wBlh03ZbeyeE=;
	h=Message-ID:Subject:From:To:Date:MIME-Version;
	b=KyAfrHb49K3vha9ho0rDUex5nSxk4zyZrGlnJfmw7uiAlT2iPfBqeR7ULfW22Q/9d
	 ywZoAzsbPUKi6Y7ZJm7KXzoUdg7iT+pigo4Mh9hhfzekVXrmhNTCU+IE4S8N4/U+5V
	 Z3zpT88XK/Fyrrdf3LyRZZ9zwqxlDj627DPVo5uw=
X-QQ-mid: bizesmtp79t1737017313t5p97ssa
X-QQ-Originating-IP: uJwDwGzemD7vBgxEkg2C/dl1pinQZTQ0suCMuSBB7rQ=
Received: from [10.20.53.121] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Jan 2025 16:48:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13648819181761774000
Message-ID: <E679EA1C52B143B5+5387e970e4bbc6637d044dcd9beebb06d9a65822.camel@uniontech.com>
Subject: Re: [PATCH] erofs(shrinker): return SHRINK_EMPTY if no objects to
 free
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Gao Xiang <xiang@kernel.org>, 
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, Jeffle Xu
 <jefflexu@linux.alibaba.com>,  Sandeep Dhavale <dhavale@google.com>
Date: Thu, 16 Jan 2025 16:48:31 +0800
In-Reply-To: <d1e4c851-b399-4d6b-9e0b-4124ef7bbf64@linux.alibaba.com>
References: 	<433DB98624BCDF95+20250116072042.189710-1-chenlinxuan@uniontech.com>
	 <b33944b1-18fa-4a27-858f-5922ea1e1003@linux.alibaba.com>
	 <AC9D4F55C39C7580+c01e5ccb2bf8f14644d02a84ccc834ad49f86fbb.camel@uniontech.com>
	 <d1e4c851-b399-4d6b-9e0b-4124ef7bbf64@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NV5clquThfFEYb1qI+sYk4Q1mFeKUhy9C0YIMm6pKyMUiGR8IeLP7oqb
	DE5wQk1mA9X6BMRZqFuVCmnLUZJ1OSyEpb8R2WOmm5fFZbywJLbAFYP5pd24JgIFoZssoOL
	fbBqlW5X6rQBYKJ5xL+lKaGy5dGqvyVjTcrS2uL4HLzcnTEQwVdqQmm+vCOIo70awbRUqez
	WyE/Fe75ngycomAqdXNIUoqpfEaCF53J8fFNQsZeeO/yWmB9dIUq6y+rbn3DwVkRFRdEOUR
	jwFKjqVwWdJxbq9Ncbw88G4lUCU5yGO8ErqIgE3zvjFEMWTYpEVcS+4qLUD4g+2+Urd8N3+
	/JDdOdETbecFIOBk5pMlFaq8DSVTzBKTGQfFZyV/j+QqHPEegsGMpuOWTTVNUXzLsJrs0DP
	i4iJgUVbT5tu8vJhhZtqr+hfuW9XpVmvEKE4fC9T7TmNwHCZpQLO1kOF5NJubDfQzod1qge
	WauR0Ef/zavc410V4AM5YVNeOXka+bUyA0Vy5KgtgH8xCa6zR3jt8m5t9ifrWxB44jzzICQ
	FbfQMc0Tb71ajjZ9x5tkJ/Etca+3PF+ehCt7ao3zGdgM7JB+93rWXZNVny5JIVoRAxXb2j4
	AxDZqqAhDNlVmfpWqIcLQl4Vf8N85QAfW4VVec1GZlgKDUv/xnwqKdxCmT0wy2uCzhhwEOz
	0gug8yEpEdK5imljobtoY7Fw6nScyp4RDsgd0gQ+5p6vUckwoWszA2rN89mcYcfqcz9gOrT
	j1mSBCe7lWOvX6BPvxSU3RK6O4kwyX25tyztZanM5wxHSTahTt45Ry00bEOvbCxeI5olCdY
	Be9nuZrCREwa5+QsRcrG7sTdDqd5l70Lv2aI6e7ljEFRXITWv5nCv2UfhuRWsxrQOGN3egt
	UyCFpgPrVK3aE7uGc+VyS9OMMocZYFXKLfWIDiFhmbVn+6XGLLp2ohjY68a9NDtb1tTs10c
	kAdX0LsT0EuP0dutVH08LooAtOTQCgzRd1WAbYMsKx3u0t+F+VFpiYsv49zDaFB0YhPnUPd
	AgEqv4JQLZC4ywvyiye3L29jLrDQl+UNK69hAhqkynYdRXESjUWAZpu+Ojy0VamijqoiF2Q
	sJaZ/aQ+bHe
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 2025-01-16 at 16:45 +0800, Gao Xiang wrote:
>=20
> On 2025/1/16 16:24, Chen Linxuan wrote:
> > On Thu, 2025-01-16 at 15:51 +0800, Gao Xiang wrote:
> > > Hi Linxuan,
> > >=20
> > > On 2025/1/16 15:20, Chen Linxuan wrote:
> > > > Comments in file include/linux/shrinker.h says that
> > > > `count_objects` of `struct shrinker` should return SHRINK_EMPTY
> > > > when there are no objects to free.
> > > >=20
> > > > > If there are no objects to free, it should return SHRINK_EMPTY,
> > > > > while 0 is returned in cases of the number of freeable items cann=
ot
> > > > > be determined or shrinker should skip this cache for this time
> > > > > (e.g., their number is below shrinkable limit).
> > >=20
> > > Thanks for the patch!
> > >=20
> > > Yeah, it seems that is the case.  Yet it'd better to document
> > > what the impact if 0 is returned here if you know more..
> >=20
> > Sorry, I have no idea about that.
>=20
> I guess it has no difference if the shrinker is not memcg-aware,
> see:
> https://lore.kernel.org/r/153063070859.1818.11870882950920963480.stgit@lo=
calhost.localdomain
>=20
> But I'm fine to use SHRINK_EMPTY since it's clearly documented.
>=20
> So could you resend a patch to address my suggestion?

v2 patch has been sent.

>=20
> Thanks,
> Gao Xiang
>=20
>=20

