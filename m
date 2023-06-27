Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EA674039F
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jun 2023 20:55:25 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=YPBkIugz;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QrDRv0gtDz30PW
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 04:55:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=YPBkIugz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.15.14; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QrDRp5BzCz2xpp
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jun 2023 04:55:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687892109; x=1688496909; i=markus.elfring@web.de;
 bh=XWZxvm2Kbt8hf9rPHRzI0lzOAByY+3tKkwS2i3SiQnw=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=YPBkIugzt7toYZw4weE/bKkQH3MZyukKEv5tXJslwUC1DS27OaRVI0qRvtuKS9Bgb3G9N5L
 oard6K4TOglhLPWybNDicZflUdQNK10OJtPDTxNUFT71Erjt5lJzlTpD7DggWBbFS/eoXPMnA
 FBM35hZlEUgrjFXYhMqpVEgVeIg0GRPoIjOzphAnKCAz6LNmPgi6th7iO5PWeM+3G86S2mFNa
 P7CFsvTmC7/PRz0lPIzapA9VDMIQ/GsPtEEC3utPkhhsn7au7Ymb4p2O0snqmEpxy/KOA6/uA
 Lfe5x8IisThMTNDm+CIsJDNSY2XmWoATDEe2JaM8M/Gu8KO0159g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mq1CA-1pixhv05J4-00mxeP; Tue, 27
 Jun 2023 20:55:09 +0200
Message-ID: <63f626ad-276d-6daf-541d-c2d877eb0c19@web.de>
Date: Tue, 27 Jun 2023 20:55:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
References: <20230627161240.331-2-hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 2/2] erofs: simplify z_erofs_transform_plain()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230627161240.331-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g/3zX27NM8usez2j3C66BIrrEdg7ptQkkVGATvswtsSoyijda0T
 Ky76xOn2WUrQiJMqorLOwWm0srJAkiEbFu4EmCvpe6ShDkfpBoojJHcAJrtLkkeesD0Twn8
 bMfdQRXozytmqiLOSWBTmhwd5CTfe8Telh1+c3yA4TgB4GF7YdGbed2I5euPailk/XyEUPM
 ihQGqvcbZlqaoUi/3SMQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RqJplO21vbI=;5g0lUSSXqmoFsmY/Gak34NvJdqb
 rjBIF/QgFpa4P/q6+5t4bMaGmv+90kRQRdwkxjLFYO/N8KAB8nJMh0FJfcY6uWpIQzzSsZaDA
 0q/Uw3Mo4xmXD9dV6bPDv+UnSSFnLyegBLmCJT6nL5Md3549pVBd3NCaqjFZvUhGenJpJtIFQ
 hQdDE9GPspH3Y/m1GmIt4Dq55dpmq0DbDHCv/LS3osfm1np6F7qp8YpGrfhGiOC4pk41mcDIA
 /FU8YGVZvaLWsrk5FzBg2ifiryUhoJ9Ybly2aWhriXUTtxAlXUbnIZW6ZfvyY31QDiJG8iehE
 IV+gPASb1eYL6QVE7fBFst25qh1lcY3rQc0F2kneOBPgEt+2XJbf3tTrhU0vae8mH1Hcij7vV
 DDPby+kdunS2bpHzIUKc2lXTAtKSXpG1z9uoP2umOWc8F5hWZu36VI4e5v6ac85ZFmuyBJRhj
 rrdajy2ioUOn8v6+BPGmv76917pYoaA6L25gB1OkrFN1IUa8GFTsQt2KMOUOFZ/NAWLhY1zrR
 OZKXg51mWpgBrvr8IvRdPn4WNqw9IYpoHlghSmheuvyaXFrV8KTwdshkD9ij5p1tMyTsmVYcq
 R5blUpO4gGcSAxgCxEFCBDRnn3tRYhQGMiX78LLpigy/rxlgbyzfSOytP7mILF1sPLRsEWeuU
 InJxsaDgrXtRHewIqLg80C+KutEsuPbhWfcSLFx+NFRzobgTUOX9vz8aynoBJvhHa6qlVoUUT
 4dIWF6aTtI2dgUBd0cbIOg4AncNGczRd3fA6aOf/AYm8kNTlL4c4p1aODqd8FHy9nF/QTtGxV
 KDPDFgKGOgGoPzVgPLT9FJ1n60KTZy/p/OWdZRH5vUHMflzsKXjR7afRl0ZSmWa36KSRa1bPX
 CiHmgxoXyftYldYpBO4YQnRZxBmyDCVNNB49c28RxFuK0Be8pqawp4VdBHeEb7l9Ivkm08mT6
 I6iuBg==
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> Use memcpy_to_page() instead of open-coding them.
>
> In addition, add a missing flush_dcache_page() even though =E2=80=A6

Does such a wording really fit to the known requirement =E2=80=9CSolve onl=
y one problem per patch.=E2=80=9D?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.4#n81


How do you think about to add the tag =E2=80=9CFixes=E2=80=9D?

Regards,
Markus
