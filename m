Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1526740394
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jun 2023 20:50:02 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=sz8y47kl;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QrDKh1D1zz30PZ
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 04:50:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=sz8y47kl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.15.3; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 314 seconds by postgrey-1.37 at boromir; Wed, 28 Jun 2023 04:49:51 AEST
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QrDKW08tQz3075
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jun 2023 04:49:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687891786; x=1688496586; i=markus.elfring@web.de;
 bh=fRFngRmiwaQegelpVV4IUIKZ/nLgwyI+rOCCyfynWgM=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=sz8y47klMwYM4oMqPK4r2KUkZgKzrgn9AKo7tWbAdbawdBteX3zAFFW2M88VQ5kkvol4StO
 2LOWPOllj++Efsuy3P5PmFDupIc8+UYh7U1FgyY2vav3vPBeih30tnP8DkfSPz/pW4luCLAUt
 weQr+Ys4gQ1J6mpND9rth+e/IY7qBszOEBaidzs3nkrUkhlNJna8MAgEg+AGXY22y1l+ryzNn
 zwMrhMXYzUVDUFRKMqGVViEvMU2dV4F1dZPhGswA/lFC7hfH9izviC0EkXlPfWsIzqy+IndmG
 UIVYVQOjk0T3TkBYguciOLiug9W4A4Hdmr5o6lQS2nZ9iSGAr+wQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIL0C-1qJhKm0COq-00ENkh; Tue, 27
 Jun 2023 20:44:24 +0200
Message-ID: <b16c3172-62ff-3b9b-d7f0-4c848e03e8f9@web.de>
Date: Tue, 27 Jun 2023 20:44:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
References: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2] erofs: get rid of the remaining kmap_atomic()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EljadmQoePRbtKgdiOB19dOhh2g94jr48Q8BrAjVzZAATzY4y/U
 mVlRAwjenTxvVKIJPG5tkBBeBX6VgiiNjhyjKFCS5JPsqPQn95QkQ4bs+QxhOFxZIuhSCvM
 eoPDBvpgSpiiXP1LIOz03hQDFmyTeRtL7xuATGMx0VsAzNS2r2JqH5DtH/EBKZtGk+5LsL6
 sW7pBY5CQmhqRRrNEdQAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vpw9hBEN9/Y=;GV/0PY/DSTMMUZdvvsmGNXJD9U1
 /emPZsQzeZzDiI7ptotl3qqJltCGdV+J1eQ1kuBVTgKwpx5qkf9YRbKwWE1E0bvn0KYlmEnrQ
 fkyDDajhqm+Y4XN5Xb4PEvD3dJ9jquIowP0iaik69jN5KpkFBmfkdEjBCtAC64lLkDZCFGapW
 gJ24100w3U8tet+aHzRpYMaZKRVF77j58igGXUK0/3lR2shDDGS2SbL/W/VSE0ePk0Qq4eZsd
 vlHDsLaxPJskDFlv2IdYZbQt7zNuMqn9juUCu6mclC+eDX67anhGp1tc53Otink744nSoOs4j
 MF7HNUZgVJKqScNG5FKKHEiCKuEHQaKGmQeDRpLjcFyd9xnR3gOvR/2OyiN+RwbfHNLuRurig
 Ea9/Jyya+WcJw9W+xrVJpirp6GlUDP7QpbwLwxWLWwRS191YabQ5uWUGJ1n7fL8zSdr+pXVAN
 Np5MXJvRR2pPI2si+TvIx7sHvTpu0F5MyAQIahlR8Lv1/9cEABV2lnaqUtHt9+HXHkjoHDrQJ
 TfWem3l24Us2/gu3j769WVO8S5raxTfz3fs0GMImJ30fRqjIJIdecTIywtuuEG19ANNhTq5GY
 JYsKf5RgPYBZ7+4FL4ZoUNIugaxctE9UOaxMDLxxEysbyQ8pX7REzx1pu+c6g2itfx9i1df2i
 +NBPPGoSfu3nXUWkK7azzneSedct7itt5EJqTTBLeLvoas7+B7c50g1cH5BNOIxSUBPwQJeHK
 EqiobVGD/qezBcM7jrY5XFjZVspW01IbLpD1r4B5vgKLCyqvUpYkw3gRJjcZrf/cbsCpr2uWK
 q4bAHN4bNG7zr0z1q7NHJD6L2Ot+48/JEEenUexbmN2akm1MyjGGRMtPiE/p4QctmpPG6lTkd
 pGtg3oTtSjU96zUJvXCtQUKTbn9Kb3b5V5xrtw/NIcabTslapyUUM73g/T5H51R/QiB9EfRoJ
 rqnHXg==
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

Can such a small patch series become a bit nicer also with a corresponding cover letter?


> It's unnecessary to use kmap_atomic() compared with kmap_local_page().

Can the desired comparison be improved any further?


> In addition, kmap_atomic() is deprecated now.

Please choose another imperative change suggestion.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.4#n94

Regards,
Markus
