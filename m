Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C22A6D35
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2019 17:44:21 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NB8M0bxRzDqkw
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 01:44:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567525459;
	bh=sQEdNQemsI+QcqzUL9P3s/V/ZUBw8b/Y2VJb3FdbonY=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=HBy4+pjPmPB42R5CpK8602nKBHH1pzGl3mloCMEddiu8U+wRXxiXtjQsFKKrktMht
	 RdoCAlb9yvBzf2/Me7gFdVyhWJUFgbfnIbYD32i2UI4jTrbxrlXuZVdGSwXQe2ntcr
	 pZDPVxSOidB10QSMKuLhvVAF16AtVZgnRqGFUe8yRsNQ0myg+YrwYDcwOK2Evt91JB
	 svGGg9GHXrg3+yyuYMCUjNAFYeNtcMwMu4akz4aXtcA+iILnPqe9DIaCzWELjNxv8t
	 83c508Tr2jSJwW3KAYVihXpArHVRx5nBrzhXGJ36tDs51TcvmUEmwRgfAMHHqS/iAd
	 X/wJYQ7heQUlQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.177.82; helo=sonic305-20.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="inOkNFLi"; 
 dkim-atps=neutral
Received: from sonic305-20.consmr.mail.ir2.yahoo.com
 (sonic305-20.consmr.mail.ir2.yahoo.com [77.238.177.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NB876WjJzDqRM
 for <linux-erofs@lists.ozlabs.org>; Wed,  4 Sep 2019 01:44:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567525438; bh=amQaLfsn9ULZ6xSgxRvXFlLkkzxAfo+EgjZ/LcStoG0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=inOkNFLiuUBkOB94EFjoigF6vTbXFopGu0YEYVbZPLwjtLIjKIOwqyy6Et6IT8Wyb2sXRW1K6QfGJJR9/wD3Zj0gWhp3ZEnwOdUEwxYmAkETelsEehMsYOhUuTbECcHx1hZyEt8lr2nXaSRNwM2z7VLbG9Si9nbkSCXVK5xNBHL9+kzVeKF0ZmbMvQdvoZhjQKIuEaXaTbFsbtYfzea/UG0MBL6MxEyXCrPkkUj+C8Hc17dO1jVsgExuvBMw6HgoDI846SdPv7eu6Dw8EcTp+ln/LOdTEIxcCrHU/8HQTWFvTIPgYo+Mfc4lNOQe9qUOeYoQfKT/WCckSSMRazciqw==
X-YMail-OSG: 8UQ0XYsVM1mLlKEPHcOu0KYQBaMIBtw848cc12eLBxHlDVJ2w2IjOhhuj2pFk6U
 T3R9.I1jWABZYSe9mKMUnugbuXpSvY8437zunRdkfTBzIhx1fOWNhm_LkQYSOkDkfTWePhvirbiV
 oMI9XfH0k7A2ZkbVINbccynWxWhC3mHkmXZ8_6nFH1S_498eodVNo2kdToJUm8el0K3WgOHNflvB
 mR6IhZbxy0HRTIH3ovwGVSgOSE583Tbeua9CP6IMNiz3T8tsvLiirRysAN.5SevMddO1Ocm455ky
 XMysa6_mYS0fSJ2m7FHbl1JIwcwcTmDnbm7W0bkLEqMJrYEd0j0k6MYHbd13HvsOr.OQpi5h2adx
 KbW69xlR7sqUN6vg.KGxAcUJAhrxGlCpsHbROjfCNcx9Q67W4MnZn.ZAiCP3bxpiAA3j_jGhwCUy
 BVU9FP0LUX947erlPjb2SfSpDey_quPTQpgznc6g5lipcwZhL7oJq6ERpyXGmksGV2L8.1efHjN8
 1H6R8BTMIVHTMVHUwKrEv8kycX.h4MiSi2JY4vGBcKUxs0tQ1ppOMT9hqV.Nrhoxb.FcuSoXF9mC
 68JqSlOWs.1hO5XkwQHEhZ1At7XOh3JpJyYLgSqQID.au34gN.LfMLqCmfvzw2QD.tbMm1lKmDc7
 he_4PEXePeC6luG5qmlbvOM5zZyY6haevTqgDM33eb1EjHzKIcrfbipiU03VgT5htJRWt6ymtxVm
 Q_le.S4qHRSIO8XREEb_kA2.HPJ2FAqN8ZKUW6Lo21qGy.zsSNTtCIGodk0mr4oMcmk5PG9CuvYR
 j5S.yT4CzdXFsg1Hi6fuHX0Tc8qJxuf68vJmsHgedqF3TNQVQMYee9wfzWHB7VElQKoHFgd1sw7r
 K5F0P6n_PmVXxc8VaulD9R_JN1xpEPtsZfBhJSwNOscz56j5h6pMDXVs4qsucUOB29ia56jXGlhV
 _lR3OrwoQ1Iqh663yoCsBhNwe6WiG_ElrZ4n8qR2Zb0xEqAXcwwPtdyPq8Xa2njZMDSv3kD.Fatj
 taRAoYPOmnLIhSxUB4RkqQnKBfTtiX4eavHlZ4qYLiME2BT5FJhKAqhXlK_srOHfoCCtRC77neKp
 uEga0Dyh0.1gXkqcn1uYRbjW_tt9S1Z_3Sc44eYRTfkFOq64V1L3TCcXqr46PwbUUA8EdH77ByJH
 MPFXp55uoVox4gl8Uu2ZB6J7bg9vhjlKGoRiHN9DESPWB4Fkfg6zE36W48BuqCHJyajbUg4oD7X7
 1CdDFF7Ym9F2PsdRXYsZQFkSFv5Q3oyk-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.ir2.yahoo.com with HTTP; Tue, 3 Sep 2019 15:43:58 +0000
Received: by smtp405.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 3edcc4dc058dc029291ae38d51f9ff23; 
 Tue, 03 Sep 2019 15:43:55 +0000 (UTC)
Date: Tue, 3 Sep 2019 23:43:46 +0800
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 00/21] erofs: patchset addressing Christoph's comments
Message-ID: <20190903154345.GA28846@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190902124645.GA8369@infradead.org>
 <20190902142452.GE2664@architecture4>
 <20190902152323.GB14009@infradead.org>
 <20190902155037.GD179615@architecture4>
 <20190903065803.GA11205@infradead.org>
 <20190903081749.GA89379@architecture4>
 <20190903153704.GA2201@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903153704.GA2201@infradead.org>
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christoph,

On Tue, Sep 03, 2019 at 08:37:04AM -0700, Christoph Hellwig wrote:
> On Tue, Sep 03, 2019 at 04:17:49PM +0800, Gao Xiang wrote:
> > I implement a prelimitary version, but I have no idea it is a really
> > cleanup for now.
> 
> The fact that this has to guess the block device address_space
> implementation is indeed pretty ugly.  I'd much prefer to just use
> read_cache_page_gfp, and live with the fact that this allocates
> bufferheads behind you for now.  I'll try to speed up my attempts to
> get rid of the buffer heads on the block device mapping instead.

Fully agree with your point. Let me use read_cache_page_gfp
instead for now, hoping block device quickly avoiding from
buffer_heads...

Thanks,
Gao Xiang

