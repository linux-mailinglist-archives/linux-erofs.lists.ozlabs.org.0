Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 741E91F0BA2
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Jun 2020 16:08:34 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49fysW6T5YzDqZq
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Jun 2020 00:08:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=gmx.com
 (client-ip=82.165.159.41; helo=mout-xforward.gmx.net;
 envelope-from=hsiangkao@gmx.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256
 header.s=badeba3b8450 header.b=FwaLL8bQ; 
 dkim-atps=neutral
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49fysM6bLyzDqT2
 for <linux-erofs@lists.ozlabs.org>; Mon,  8 Jun 2020 00:08:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1591538879;
 bh=ZVlRvfNTFJm/9SDfi9Bs1uNUmWgIntdXBP+FsWSDJqI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FwaLL8bQmWCgRk5kJo/5gDjnJnGuQBciL9Ndou3x9FTzEltipCyHeZ6KKCHnoYhjQ
 JGYfzryEHtz7kQsiJlIlgA6pWVuH37faOVwnQV8mzRCEz/Pvca+8TLsKNh8mM9Z4wp
 KUy7CwzHFOwHxhhENdx2dD6QcSKDHjmwg4ku5Muw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([36.63.208.217]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MryXN-1jC7ND0RHh-00o2NO; Sun, 07 Jun 2020 16:07:59 +0200
Date: Sun, 7 Jun 2020 22:07:46 +0800
From: Gao Xiang <hsiangkao@gmx.com>
To: Li GuiFu <bluce.lee@aliyun.com>
Subject: Re: [PATCH v2] erofs-utils: support selinux file contexts
Message-ID: <20200607140744.GA17771@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200530161127.16750-1-hsiangkao@redhat.com>
 <20200606081752.27848-1-hsiangkao@redhat.com>
 <fc29791c-14c1-6f10-bb5b-fd31877feedf@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc29791c-14c1-6f10-bb5b-fd31877feedf@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:5T1qSJSJ8ENGobxFQ54BBoGj1v8giMcLA4Ymv3H7OYY7YHqdohP
 lkJrCrOK2ZvKmPA11rg3PPlfcqMVcQd9pJ5Bq/0zic+grSh12/J0ijj7OmWYzG+4gapr26V
 kl+sDo5L+2bWSFVdT6PQl3ELTRHXRrF9HSizK77mImKEhOUqFxwFXcoPOQHzLkp2hjdfJ61
 6S3Vca+BsJcki0yDznyLQ==
X-Spam-Flag: YES
X-UI-Out-Filterresults: junk:10;V03:K0:9j+syXiKZOw=:nDt2IXpd/+u2AeOZlrCHYvFE
 jytMJ5AFFxjqKvHptLJQ4TA4Dtq8Z+Fzn15syRk6tfWGlKS0g3R5kqnhawamLd5cEWkd5+HfO
 /MSwMNzbZFps7wvglJI6xXkXM/U/DSQJMd5f/f9la7cHXZK08piz0mXZKr8xsrp0rcpbxvdIz
 Id/eBhiTBAyMmic1G6MM4QHc4B6+MMU/U825IneRnz1hwH2QbiiD83VWVkd2fjMARaJsGV83Y
 inEZX3x2e6K3Qmev8LmfNGIoXV57vZeIQtg75ZLznBEiFxF0kXwVKYwdYejdJGzDIafcsiggy
 ol4uGIzjQ7nZgI32zcFAq9xEAx6kRXIk4Fjo+Uq6oFNabRzeQvcpUgo+Vc4thLztMzrXTlN7F
 sVIxVZNFi6PxzSgOIQlkaJ5AQyEv5h6YhCxhf/3nRUZTF5Si0REYwVNkI/L3ZM2FQf/HZLeca
 5vmXQP1OA3IjfLha5lA8l4SirxwH7ELcIOBsB9dC9pVfFQ+nDqgUwwdqP7E57HamUF8niQlyq
 31hbk0+tlivhZIAnVq4PuGxKp/mVfxNsxLkG4z0NDOeRJ0wUb+WbFIAXeUOgo33kyoakMK9Qj
 UdvWTUljTI22rWMINjeU0CSvTHzoyo7Vja4JFciePyOOfENks6GtZFfGbbDNCjbZetXvgNC3Y
 BW99cFh6IWMl9q3zhE2yvu0VgDj5fJyKlNB+aKKeHicnNVZsInW/ZCHqOE29ljEia0Hm3uPml
 GH+DUm8qTurNeEub13P05oIFYxfHT3K08+TDVumCy32gj5r7WrGk+7c5RZ9KNel5nqzedLSsA
 wj0WRjP9n6HCEoC2lOBy96eCYs9gfCRyl08wA+oguADuWAC8+fMaIunb8dU0Owp72LgD9PZpQ
 JGzVFkX5n/MJBdMGNSEKRLR/977WJgC1MegS54EnmBDMRQeQug/VXgwwMgDQlAeWFF3gBTuoU
 TaA6BzMmFEtkD+7m6KTlVbajsgQHi13/YJIKI02W30ugZRqMB3WRnIrWl3c4lulSTOA2n3Gkj
 Rf5qFPRCCG6myuOqVrs3Ktt/C5RoITVEplSk1p6V9Ktmrnnh+FmynLWRF6f2BSd/nOAj5ZBeU
 8M6uyTtvfbMzcmGSKFMC9Q3UqXld9ikO2WZZucLM0Uq1FqXR7Dnk5rPfdR7ri+NPbeYDZHPKa
 KWgUgrDRKyhllYPWwgQA34XyFZi6rNjozIE5cpf7nSt638EVliWx4oXiVP8mzK1Tq1OtlLiCM
 2296fAiu2ZYlOFGiMKl49eTZJ0wPuILwepLMA==
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-erofs@lists.ozlabs.org, Shung Wang <waterbird0806@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Jun 07, 2020 at 07:49:57PM +0800, Li GuiFu via Linux-erofs wrote:
>
> On 2020/6/6 16:17, Gao Xiang wrote:
> > Can "with_selinux" to be set as "auto" ? it can be decide by the host,=
 selinux installed enable selinux feature

As I said before, we don't support that feature. It's really unsafe.

I think you can try what f2fs-tools or some else did (e.g. just try
./configure --with-selinux without your selinux library.)

Thanks,
Gao Xiang

> >
