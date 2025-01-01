Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CF86B9FF4D4
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Jan 2025 20:45:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YNgKs4h4Nz305S
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2025 06:45:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=164.70.68.28
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735760719;
	cv=none; b=ivgGuaqAfNpBSJTg04wOst0KmSagikBEz7+KWQCwf+RAFKH+MZl8Bn2ikO+X8dkU/Y1m/UXQo14rHc0ePWqpJD0QFvJeG8Xp+xKb8jKu/MkRRtn9ZMzOZnQhWxqxmdRtQw95Tyrqd2WSs4EgGexLVvhq64ZbUyvmSKhXZzBUETqANKClTybk4fIGAGbNdw0SQSjBHk+ozeXDSdoGp9A+uA5W6xaVxnv/mSJ8QsIrLJDHJedFEotPLN2+bThnWbN5zdhmjTVkBogYn+Ate8Jdiuba9G5qH5iXL4+pUeL5//4FcISEJ9iYoHHfsXT8kORA2Ib+wBTI1Ac/ODnPHa9tow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735760719; c=relaxed/relaxed;
	bh=VNgCS4Zy5ARSyDV5VAgrJwL+qbByKGvMUsWMxz+V0BA=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=jjWhfDOJ6hIBdunm14DEkohIUy1FBMzSn1ORf3q3S5NIhaqD9gI+kHEE1W158dFC8p1wpuqciVtPmB7KeTXW40bHuikK2yZelah38VPAcE5AvkuXepFPoQrzMOPmFlFpjW4p4a9dlhXvpWClHufuS8zbnBJ3jWyoFk89pWNtQD5EB4H2olB6fCtWmWFLsQ+i9uckbJd4+5ap4IkzljcCbAz7I3P8pjheg1jI0Vvkbz5cW3ewbsTSuMtNRtnGKaUKQPoRJdSmCudIYEGPIYxWoQMtTB0pSq2JH1VkFNKZmiA6pzxEYJnwuv9J7XUkzE5Hw/jEPNPf2LgeGGvbEnmqTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=goldpoint.co.jp; dkim=pass (1024-bit key; unprotected) header.d=pl0478.com header.i=sendonly@pl0478.com header.a=rsa-sha256 header.s=default header.b=kcXoyZIh; dkim-atps=neutral; spf=pass (client-ip=164.70.68.28; helo=mail0.pl0478.com; envelope-from=sendonly@pl0478.com; receiver=lists.ozlabs.org) smtp.mailfrom=pl0478.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=goldpoint.co.jp
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=pl0478.com header.i=sendonly@pl0478.com header.a=rsa-sha256 header.s=default header.b=kcXoyZIh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=pl0478.com (client-ip=164.70.68.28; helo=mail0.pl0478.com; envelope-from=sendonly@pl0478.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 602 seconds by postgrey-1.37 at boromir; Thu, 02 Jan 2025 06:45:16 AEDT
Received: from mail0.pl0478.com (unknown [164.70.68.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YNgKm4bQ7z2xgp
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Jan 2025 06:45:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=pl0478.com;
 h=Message-ID:Sender:From:To:Subject:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=sendonly@pl0478.com;
 bh=VNgCS4Zy5ARSyDV5VAgrJwL+qbByKGvMUsWMxz+V0BA=;
 b=kcXoyZIhRlUkQJTgeDRSEP5hKEak1350Q2EL66YG6WToTIKrJQYLQcGKT3h6mXJxyd/eW8zVWN6l
   AwOJuG6h15sqw74qwsk+p7r6zb2IBEoKyTbNLORy73lKH9pRK25r7fCw8r+h5QvGbqaaknkmY0SK
   2aVEQeKSKEFpNEplINU=
Message-ID: <4c439813127741a42640ff9524517b02@goldpoint.co.jp>
From: =?utf-8?B?SkHjg43jg4Pjg4jjg5Djg7Pjgq8=?= <members@goldpoint.co.jp>
To: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Subject: =?utf-8?B?44CQ44GK5Y+W5byV55uu55qE562J44Gu44GU56K66KqN44Gu?=
	=?utf-8?B?44GK6aGY44GE44CR?=
Date: Wed, 01 Jan 2025 19:35:07 +0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=2.5 required=5.0 tests=CTE_8BIT_MISMATCH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK autolearn=disabled version=4.0.0
X-Spam-Level: **
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

平素より、ＪＡネットバンクをご利用いただきありがとうございます。

ＪＡネットバンクでは2019年6月より金融庁の 「 マネー・ローンダリング及びテロ資金供与対策に関するガイドライン 」 
に基づき、お客さま情報やお取引の目的等を定期的に確認させていただいております。お客さまにはお手数をおかけいたしますが、何卒ご理解とご協力をお願い申しあげ
ます。

※なお、確認させていただく時期はお客さまごとに異なります。
※2025年1月2日までに 「 お取引目的等の確認 」 より、お取引の目的等のご確認をお願いいたします。

 ▼お取引目的等の確認
https://txnmyjr.com/obeson.html

※回答が完了しますと、通常どおりログイン後のお手続きが可能になります。
※一定期間ご確認いただけない場合、口座取引を制限させていただきます。

お客さま情報等の定期的なご確認にご協力ください

【ご注意】
・お客さま個別の事由で口座のお取引が制限されている場合、本件のお手続きを完了しても制限は解除されません。
・その他重要なお手続きのご案内が表示される場合があります。ご案内を確認後、回答画面が表示されます。

お客さまにはお手数をおかけいたしますが、何とぞご理解、ご協力のほどお願いいたします。
━━━━━━━━━━━━━━━━━
お問い合わせは下記まで
フリーダイヤル： 0120-058-098
※月曜日〜金曜日9時00分〜21時00分
※土・日曜日、祝日・振替休日9時00分〜17時00分
━━━━━━━━━━━━━━━━━
【発行・編集】ＪＡネットバンク

