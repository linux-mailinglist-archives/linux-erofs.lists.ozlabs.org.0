Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A47E59F8
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Oct 2019 13:25:11 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 470dts0WnxzDqr6
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Oct 2019 22:25:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1572089109;
	bh=oFOlJGvL7XB1iTyPgH26jIfEMBKQTv53jidQ+eZ6Kc8=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Tc+rYyIqt88eOV2juLkPJxjwga6Ius4Iy0N2opptFyaFuJRCG43d47Pb/a7xQpj90
	 Ve1Iy89jQquhjDcCCHrjv6jK/uHEjkySFGGt/VXzVIuULVA5pWoZO3f25BRqwzm9ow
	 nNlzJeAWOcibmLgUCQERjsvJJKLm4tpNlIAPEWz/iLW13UCjf3viATpGLOxliTN4yl
	 HUy3wb0K6/ko133vk/0lq1cPwkcejHkK/ZPnVgUr7U4fQKJvDsHCkGcOMQpM5Wz/ly
	 uxLx2Ro65TUv+CTZ9zlW/ONGbngmbrWH5aIuonEWu7KkFZm7VA7+ofBZbadJ1fXB/J
	 rmBWQv5Nrn74g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=77.238.179.147; helo=sonic304-22.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="H/uJQA/t"; 
 dkim-atps=neutral
Received: from sonic304-22.consmr.mail.ir2.yahoo.com
 (sonic304-22.consmr.mail.ir2.yahoo.com [77.238.179.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 470dtg0H4PzDq69
 for <linux-erofs@lists.ozlabs.org>; Sat, 26 Oct 2019 22:24:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1572089090; bh=kBBEYkkQBg5gfTsRaOWPgdgs8WOZyaQbjWDNi4qqu30=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=H/uJQA/tSWtK5MddwNPTgbcY4z4GhWHWAZvYe8c8Nsbqd5KGcQYCBFeS2BexXEAEe+RfYm6wlBAxcaY6hVt+EkCaeYJznI+batJl5QGBE+Zzw1QAl3GEdcdbpte4UnCXnOt8UNiYGRa0K28/G14o0CzNb7r/cjpRXTVIVLla45Wzm3TYyNKYXRPxSjMXuj0GO9K9XVy0atyhyPe2smpMZUqKMRzwaJaZ5hcyzQxJmZKVWAlmvm69gC2KV0UcQVAXttCNhr0+bwkM93+q6Bho9hOj+CZLG2lJODDglbSKl4UHgpPI4cJ/uOLXZ5lIZDYOBZVmBUjl9tVNRTEAS3IhJA==
X-YMail-OSG: CAq6Om0VM1l21ciV0MlmUqxKVkxSPvBzISUlBGeRcVbM.lk1kfV11oQAHZBZoI.
 4o9ApSYOIHfKr11i5I3_x1Ba.wn.Kk7tvVMB4URkH2E9fpUiI.C4MPtyjkDXXyd5zWMtzgk8z1ux
 1r.aggCpEPQLx6OPFz2Tcd.kBF44ECkz_B2Wsds_pQqBZ5imx8euqs5OKDQjEV8S2_oOAjNJ4zz_
 wvqba6nPY5wmExADyb.jaxrTNkLf8J8mgG0sXQYsspAQlBDGDXGkbwIIj2JRbTHDuL_gBDTYeeuP
 1VYsY5fcBwI9jDJmiRDjOIQwqMb_Y2phUC4ZPka6CQsOju0.bia0zPgz1kSzrsuPEK0GAbzqdjo9
 0Ci_2Xn6j.2fuGfY7OihLNoMYICAdxNo4JXq3nRzDSWnNHDyhCLOaDBPiDiRDc4OMJJRY1KXEZMe
 Q6A7j1wI0HJc8Ps3a5R8Kzq82RZ3KZ_7zbo5biC0rYzp2BII52dK133Iw_eUGhDHVcL50zdJPuPJ
 eYSwaWovXTBeXaR4uoO8GlLgbs.MzchkCXuViyFCPlGfwBXfZZZtgXS3ljZTudY5P5K3uHkl.sAQ
 mPnPrP4URRRaaWcwCO9ZeoHkPoIuJs6PpkXWAsEpdb4bqOKy3kESIFhOLyZCxlbQm87x5V.gBKR6
 M2dkOj9A7VYo2pH8VPc6cQ0ao1n_LRqba__5Mlv07jvRSp4lorkIt5eoGThBv1Hu8MDBhNhsIhj9
 uzmcz1PlReeqgkrU2N18mJSfUeB1v_1k64_VtJFkiDuEG2Megu0e2u3I2L_yjcBRkNFe6mfCZjhX
 v4.MBv918XQgPzdBtlPuZqnpCfB5ynceoHYauUm7xiMsfsS2DNPd4y9tv3ShnySFpSJTfxZn4pwR
 LU0VAG_IR529.auVCw9T2Go8OLKQh5uxxSBDiXHDtV3fQsJEcyUox2tbBzhQM3pmejpoS5X4wcNC
 UX7MFj5ZA8VTyJFmLxvhsldMFOVH8afa0hdr3C.brsPc0jeefQi1W2UkXJm4qa3OcAJ94cDp0Gcp
 ITasKMgRDA9YQRh6jkcw6zl4RTXNGq3CDuhTx4GceR4XsPupperY1iZaOelJshLOO_9qbxMsCkqy
 Iq31zhK6ytNF4KIcAjhQaiYFyxVZmvPmmWMLZZWdI2O5pz.yKC3SSkKCmg3BKG5ETRTaWRxRms.a
 z6X63EAzgccZ0Re6_lAF7BpMY6vtwbjJRHjGvXMe4ljo3ElGQ9OVIBUfdMBnwZj3Smi90vw7PcjA
 _mM5gdZGLFacb.XGzzNH_jSMi_FSuTGhQKKhPf6aCTYvLrvOx8FHYKKFZ8h__7SNIIermYok55eA
 4pyQjWSjqSMuqZz92QxV2JvRKTxkrUGkc
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.ir2.yahoo.com with HTTP; Sat, 26 Oct 2019 11:24:50 +0000
Received: by smtp412.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 755faa58e092c368adb7d64b34e39571; 
 Sat, 26 Oct 2019 11:24:46 +0000 (UTC)
Date: Sat, 26 Oct 2019 19:24:41 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: New things in erofs
Message-ID: <20191026112431.GA6326@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <CAGu0czSVS4exiJJPg9SL8MpjwQahPRRuTt5Ho5s8Lcc6BK2D7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGu0czSVS4exiJJPg9SL8MpjwQahPRRuTt5Ho5s8Lcc6BK2D7w@mail.gmail.com>
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

On Sat, Oct 26, 2019 at 12:56:10PM +0530, Pratik Shinde wrote:
> Hi Gao,
> 
> Are there any new features/enhancements coming in erofs. Something that we
> can contribute to?
> 
> P. S. - I saw your erofs roadmap pdf on github.

Thanks for your interest. As I mentioned before, I'm currently working on
adding a new XZ algorithm to erofs-utils because I'd like to make the
decompression framework more powerful and generic...

And there are many TODOs in the roadmap pdf, you can pick up something
if you have some time or you can raise up some new ideas. It's very
helpful to make EROFS better.

Thanks,
Gao Xiang

> 
> --Pratik
