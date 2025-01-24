Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BD30AA1AE65
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Jan 2025 03:01:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YfLdd1xzLz30Q3
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Jan 2025 13:01:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=38.43.111.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737684083;
	cv=none; b=LEEQYQIackGkxXwXQ4uh4ozLoJMSPuiJpBSWC0M83E1XnDPzHqqU0vQOUkK4TQLpAktczOjFoKeVZ+sv2wLIK4+N0Ixy3PV+edngrsapInkK9n8jxBbyjgAbjZ0/TheRIx6zdxUWdJWmVG8paBi4hcxqej6abDPOXLpx27Xxw+3xKZGX0SdSu2HLFElxqbFj1Lry2q6NAnn/2UBlrrxQujxdVUY9yPgBWaagIDjGNpGxpIAUk6SppN1Cs7Whs6VFEW9gcwENdYYusWSvkEureYZr8/WujbCg1pvAgtipejLVKE+27hKWjpyESM8bWQSzPHyV4gEdDFN0izLsas52ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737684083; c=relaxed/relaxed;
	bh=jTXMQLYLnzzl4tMhcmVu4eyUgjcdCEZafbd/djhgyDc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z0duWVSoFrjhnOtdJvYi/2qx5MSxywbC61Hli377eiV0aNd0iNdYN2qU+iDu1I/QZiy8/ELijrdssaZGihUhTkGSVlkrb3OUKAncmQfLeHA/wheCVXI222jdRSVXVSEVENccwjQs33GkzM2lvOFWkvuNvS/bhnKgD9pliVSNJEr//OmN8Iq7MCJ5xXL0jgFEucCv7RD6kFnSg4s5AL/apsmoHglCuwX2E4Jw4szJq2Dbmck1Ncw+Fs5bzckXZGpLmvKkHiliitM3wNGcwjFOPrEy0dRIr166qQ2Zuld6OdSe7uUR79ofpnRXtjpJpDhT+rBUxAB/b4Fg/porA2+ZGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gosfordukfinanceltd.com; spf=permerror (client-ip=38.43.111.254; helo=mail.grupoarka.pe; envelope-from=simon@gosfordukfinanceltd.com; receiver=lists.ozlabs.org) smtp.mailfrom=gosfordukfinanceltd.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gosfordukfinanceltd.com
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Too many DNS lookups) smtp.mailfrom=gosfordukfinanceltd.com (client-ip=38.43.111.254; helo=mail.grupoarka.pe; envelope-from=simon@gosfordukfinanceltd.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 7661 seconds by postgrey-1.37 at boromir; Fri, 24 Jan 2025 13:01:22 AEDT
Received: from mail.grupoarka.pe (unknown [38.43.111.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YfLdZ3ddTz2xmk
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Jan 2025 13:01:20 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.grupoarka.pe (Postfix) with ESMTP id BFA161081DE4A
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Jan 2025 18:36:06 -0500 (-05)
Received: from mail.grupoarka.pe ([127.0.0.1])
 by localhost (mail.grupoarka.pe [127.0.0.1]) (amavis, port 10032) with ESMTP
 id D8Ppb1QFpobl for <linux-erofs@lists.ozlabs.org>;
 Thu, 23 Jan 2025 18:36:06 -0500 (-05)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.grupoarka.pe (Postfix) with ESMTP id 6815010A0BCA9
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Jan 2025 18:12:31 -0500 (-05)
X-Virus-Scanned: amavis at grupoarka.pe
Received: from mail.grupoarka.pe ([127.0.0.1])
 by localhost (mail.grupoarka.pe [127.0.0.1]) (amavis, port 10026) with ESMTP
 id mfuxerx6xtba for <linux-erofs@lists.ozlabs.org>;
 Thu, 23 Jan 2025 18:12:31 -0500 (-05)
Received: from gosfordukfinanceltd.com (gateway [172.27.225.126])
	by mail.grupoarka.pe (Postfix) with ESMTP id 2DEA410A1337C
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Jan 2025 17:55:48 -0500 (-05)
From: Mr Simon <simon@gosfordukfinanceltd.com>
To: linux-erofs@lists.ozlabs.org
Subject: RE: RE: NEW BUSINESS PLAN
Date: 23 Jan 2025 23:53:02 -0800
Message-ID: <20250123235301.926FD7924ED38D9F@gosfordukfinanceltd.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Flag: YES
X-Spam-Status: Yes, score=5.2 required=5.0 tests=DATE_IN_FUTURE_03_06,
	FROM_FMBLA_NEWDOM28,HK_NAME_MR_MRS,RDNS_NONE,SPF_HELO_NONE,
	SPF_SOFTFAIL,SUBJ_ALL_CAPS autolearn=disabled version=4.0.0
X-Spam-Report: 	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	*  1.0 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
	*  0.0 FROM_FMBLA_NEWDOM28 From domain was registered in last 14-28 days
	*  0.5 SUBJ_ALL_CAPS Subject is all capitals
	*  2.4 DATE_IN_FUTURE_03_06 Date: is 3 to 6 hours after Received: date
	*  1.3 RDNS_NONE Delivered to internal network by a host with no rDNS
	*  0.0 HK_NAME_MR_MRS No description available.
X-Spam-Level: *****
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
Reply-To: ritchie@gosfordukfinance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Greetings,

The GOSFORD FINANCE & LOANS LTD (UK) invites you to partner with=20
us and benefit from our new Loan and Project funding program. We
offer loans and funding for various good projects. This is=20
however in the form of a partnership.

Do you have projects and businesses that require funding? We are=20
ready to give out Loans (big or small), at just 2% per annum for
15 years. If you're interested in any of our proposals, then send=20
me your mobile phone number so that I can write to you or give
you a call for more details on our Loan Investment Funding Plan.

I look forward to your response

Mr Simon
GOSFORD FINANCE &
LOANS LTD
