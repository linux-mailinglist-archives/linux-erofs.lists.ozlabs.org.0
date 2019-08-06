Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBE88362C
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2019 18:06:06 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 462zyM3Z1VzDr2K
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2019 02:06:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1565107563;
	bh=DHP4DF1EnenClBUlRq4TLZAh31LZPaVO82uFLBQBj6s=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=HiY+SpaVgm75B+ZrqoWJQ5hNJR45M3geaPaswQnjRhSEZzyDEjArePQOmw3SsWWSX
	 aYOMkdv/GLmPlzb/EUR4PzjqQTm/hscHWl4bfC8OnKTP5dran80C8ghTgrGyXiyEIm
	 G+UFTfESAQ8Q0zfw3wJRUOfdXqRbfDkgt4KZM6Bf5tgtzwYDkfPjU4x/vtNzLAEMVz
	 RY1q0ABzryaGVgFoDtZa+qyLaioLkgQXRq/blh+xY47IvjWAGJkOItFhTzt+PoCou0
	 19LZjQjTvLo/DLFKj2XVOznwOcYJubzQ8NRZ6d080Ei/hUTUHfsKMkZSgjt7ROnSYn
	 0TS5HvApej7LA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.65.147; helo=sonic309-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="EoY3eQxa"; 
 dkim-atps=neutral
Received: from sonic309-21.consmr.mail.gq1.yahoo.com
 (sonic309-21.consmr.mail.gq1.yahoo.com [98.137.65.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 462zy83dmpzDqnf
 for <linux-erofs@lists.ozlabs.org>; Wed,  7 Aug 2019 02:05:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1565107540; bh=8HychvbxGzNr3Ctz8JDHfuO8aCS9Nj/73bL7rsyOfHI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=EoY3eQxaVAkuzEpP0a856aW7Q8gqK/dg+gH40ztZCMF024ymU1HIjJxGeixzZimoWLpt/cjzyer/eR1+S4cG1Bim3L720DRo1pUKOMxJroucpNo6Vtxp/XrpGAoHofexhwDEgMMOToMDG5CQXXN6mGXadOQJXZ/2bcVgD8uSLob+PyakHVBvmqZP0n+UAR+IsjeY7Xq0inUfuUQwAh6rQgaHf0uRPti9NtJGLazYnk8hwPIQXCdMGcKJlPdav8i7c1DSvhRRIKdTHfKGfMBkOJBKDNv38ttisXvPMGEEZPWdsiyYuemFj5Ss4CR6uwPX3bnAUARfKJylZAA5wVIkoA==
X-YMail-OSG: lSuiMpAVM1l.V4hhSDc3Y9wvJGUuO4aPlb4sdNBeOR3vupaAnnqqtMsm8Zot6NL
 1lvUy_a3z7Z3HMNmzEEseNUSi47jtvKjXKvhquUny9cpnELg8FsmaRxiH7TQ62gi9p56tRbFj1Od
 JTCTIXTU_NzIEQDfo1H_ME_vNTaVMCeYJJkECQFPS1Alms7TKFSWw0Aj3lodWpUAuN35cZ3d6K3c
 54ZrPq5CtH6I2YWRaEBE1TtrJPQ18hhZIOWDl_JDP7m7ejoK4ACOSqAcT.9IhvE6c7U3aA2KAH8X
 ysf0B4Z7WY14GtJWm7mb7hBfQn_pysHMFTy3lzCGaV278qPhNlFxfzxLiO9jTx7zXdcZzf0S3ouc
 gT7qWanlpNYM0tC8YB38dTZBXVahlHt1fiwaqBP3wyg6JrrcLketucoe22aGbzinbi6CBtFYnogP
 5XyIoPwX5lC8w_zch2dqxgUOMnYslsbL1i0X5cxLdtHFi5GyLIcziJzyehlz3RTiy6MwXdOCIMhE
 mixga3HZMCQFaApftqeYGJIkED9pv8GKect8lRqDzj.HSrnNCtcKi7qtQLfDmOoPdOQchSlXyIfo
 3zKV88mPfl6vf1SZDKntq7LvugzdpVr6sUhM4oVq.frTLkhBenfh7LT0hoLvZOoM8kePovagsTWW
 ENHFx8L67qioBk70wdf.j38BKvLo_Npyr0oGODqnu_l9uc8caIsHDHAzG8E87DEame_7mk6Iyzi6
 fbW8BGByk0.gRRpPBTGFKtR68e8ivtXkvnCLdFmtb5gOUORdrmNfKYNIHdJJjvicYSyeKiWOeyvO
 nvPGMuQNZ6pa.dg40qzaBCSmm6R9DO0ZoYTzmTbSjyyUSPIn3fmrcqld46LIvlB.ZsFkanH.OLYY
 8fb3Dj6KFDOGRW_zmDsmeMnW2MDVs9xQoHbOX1WDIjwhr9Nrnk7ndRQe7in6uW7u8s_NKg7Z4Moo
 5HIGeD7.SG_0hLtdPGsjFGMkK33MVGjVA9JHBUwLS0XwlwXiEzArMZjQCR8U7eGQsAzaCUspM1g7
 72lvu45HdpA6cxrJtpOPsG8vgGoly8Go4w00npGAXiRB9vHKzdE36FbLMB5CZVJ0NsiP9oOcz6E6
 wx_CAi_NG_G2vCbBta1ATa6QZrb7nr0Rsop2nbIMAR1bvYvUz3yATZtnv2VtHUTFWbL78mUqwSun
 d3t5_cpHEJE8qiZFtmmRoYD5ZV_e40yYH2FXjzMTSKyftBpP4Zl67meRrEjK6VhsZJZEK_ABHqxT
 QliO7f9NMuD2236OB9tzdXqN0Wdo-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Tue, 6 Aug 2019 16:05:40 +0000
Received: by smtp413.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID e1834d8f894579dcf0a23a387e31f975; 
 Tue, 06 Aug 2019 16:05:38 +0000 (UTC)
Date: Wed, 7 Aug 2019 00:05:30 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: Test case suite for erofs.
Message-ID: <20190806160524.GA26612@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <CAGu0czRhmT7vSnFB-9pnJS=fhZp7RFL2ZwYfbc1RK-p5ddQ6tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGu0czRhmT7vSnFB-9pnJS=fhZp7RFL2ZwYfbc1RK-p5ddQ6tw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

On Tue, Aug 06, 2019 at 08:18:42PM +0530, Pratik Shinde wrote:
> Hello Maintainers,
> 
> I wanted to ask if there is any plan for writing a test case suite for
> erofs. If not, how do you think is the idea of having a dedicated test case
> suite, so as to maintain quality of fs?
> Let me know your thoughts.

Currently we have a modified ro-fsstress for EROFS to do fuzzer tests,
and we have dedicated constructed images to do all regression tests.

Yes, I personally think that is not enough (thus we have a large beta
users as a supplement) and we asked squashfs maintainers for their tools
last year but without any luck.

new xfstest testcases for read-only filesystems developped by another HUAWEI
team is also available at https://www.spinics.net/lists/fstests/msg11398.html
but without further progress till now...

It's better to develop more testcases for EROFS, and we can put forward
xfstest as well. :)

Thanks,
Gao Xiang

> 
> -Pratik
