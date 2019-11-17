Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F5EFFAF5
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Nov 2019 18:31:26 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47GJzF2KhhzDqd7
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Nov 2019 04:31:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1574011881;
	bh=VgUZacBGjuPGPukJnAa1yL/a19s2b2oGqNcYyEDxjQY=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=lElJtmt+/0/UelXVhAvJ3Ox5c+PPP61GVAdiLaXQj8TIB7zCab9PgfKcVqpm3ragi
	 J3tFvf73d9iaKqtLzU88epC4jHMSiK6h3FzL+oE1fhYMtmp/DZHZprpPAk2DHADjr+
	 co94hVT1EwlRrzKSV6CI4la+z7bE4STbNMt6bAkWhxUmSdtfut4yRHRqq5HLhPqiSr
	 jwQ9hX2J5HDGV6Ro1br/PPXbQBekY8r4xQpRW+HiPji8x6kxiTLxC9WOTfb4c37NPO
	 LuVH2NFhBqZEjCtzbHYz4b9VGOWx+royb7lhYNMQzJ3mxFY/DxC0ArYj0NdQtyBdfU
	 Jn1MVd2qpdifQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.31; helo=sonic308-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="DzB0cJrb"; 
 dkim-atps=neutral
Received: from sonic308-55.consmr.mail.gq1.yahoo.com
 (sonic308-55.consmr.mail.gq1.yahoo.com [98.137.68.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47GJz40xClzDqbc
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Nov 2019 04:31:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1574011866; bh=ocX9V8gSr9+8jVrK0+Xxc2RmTOxN+n83vzZkdWijMZI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=DzB0cJrbmkzuWfvi+gn4SZpMo274SaAeQkxQm6G0epf+eOP3bsn3kLy4HgDQvjHXhA2M1WGh2Gm2SDViR9VqeMakAchrwgLsHb5BhqbvRp3vS/JtR7qyppGZEuPC/Q/eHSefkZpMmbhldx8XTyphEPfOKqwnbf25TLoaBS49tEPjzlh3V6NyV9AY56/HADvNNXSKLUxhIbLz2tM3NqWc5/QCt627Ckm4p08Dncx+6JiLFyb87J4GUESCNnRYGl/F+rfwyHXGT+eLQidNy8hHMuFW7HN4Ln5NlMn2oaC3VB+uTzduCIZaWKAHazT/Z53pAw9/9vJPAu4N5nstUlGOYw==
X-YMail-OSG: zDefk0cVM1ljE5v3dg0rb2iZiiGLQFEIclEMiV8lK1bFQlmemo0aY3NzfazNMed
 XFdoAdFvnk2zbUWO_R3fZv4ZtEceP1jBXMNzetpTUDAG9VZ74F09BKF._9XabZ.Dt1zt.Bxw8tAm
 DgUN4zagocAsAo3OR2EFv6Dv4fMiJPV1NJZoeyBIVKDnOauFwbHSb6trOOfOpqbS5h9C9uUbS4I8
 RG2yd3mCpbRV6ZLNe5n10SrDisu3kdnR3WtdyTZGkTIwV2b42A052iPJPVKPODhHwJV_NyUbZr8o
 drrvWOQdj9QCYta24.5EYPNvo7vGjkj.z10kFt1LhnE6ll4kW5KvOUIqRtHmLhiwRGjOgezkwGGg
 7NaXzwKRLdLgNJl884BpL4DPRtT.hP8q36ljiVAshhm2uZxNXwp4ZbPlqYPi3VcsOssiSRe0VN3k
 C9BPYmJ56yYoLxwAbu_OWMr9hz2QulhPWhiLJep8fYGRwe1W.T3JuwiAFqqJ7h302FC0SlHHctzM
 Jmo1jf9.eJ2Vcw6BBxvxqtzy_2uK6bqICQfqtgRvLX1O8Jkdu2RnJ0128yC6ZK4v30eUHqOv5umM
 OVvH73IbbTyS9yTWKMQixr08tTnUbcjLGi9.vh_WNb07rl9PujwXzRoaSnXvCvGbfSEkUcBx7nrW
 St3XtUHF2lUKUApiDurRNRFiERZjj9pec.q2B2sB_yedD35uhBY39.aHh_l46gFOvQo0U34mgGou
 ZUkE.bLoXmzavYBGxr0zSYgZzFYlTnzjIm45SuiHfLmNYTVhy4OMiigwhqC851XbsycekPW248pL
 SUjDve_l7bPBN15kfnAAiRaHOaXLlNAdXkquX9TfYvH5u5QXRo3zKfr4DjdCFVwpQG7cXM0zDRHI
 t2MmwJ.qYsHGzorULnJVhP1IMs3xJ6x3ojQUle2J3qo0i5p0UuiD.q92rQjRYdvNC5b3p67aeBF_
 flok2mLxaGX4Qmx215utMbcgM1pXU.YdpwLpRgzlwkz3ug6hC_1yIbvWNTJ8_.MNkKkWxOzRw.qz
 ObyVAWQbVNif4QNehEAKDlcdrocJ3J5FhWulz1Ko37V6ZHldYLC0G4I2FyMb9LT00MoXZBNubSOy
 lDT_w0BHladfhhaqNfDhODh1rvCNl2rsH08eLtY0V_eDWOPCSdAUVEeErcltrt5yUqUY6MpCa_9P
 1gIILGPwqZoFS4IlWOFvSUGT8tvxECEf.4BA4ulDgewA05G.J10y3Ru9JsQcpGMBElQGLAm.Ms04
 iihMhQrybUn65km.sWpd53Sb4pArc69dxafs6oWNMU4Z6S_HFfyzK9oby4fwy3NJRnO05wpYZFzJ
 0P2PmTFwjV8v0esXFgoP8nQDbIogw7E.xkU3pp0sq5ba4T3G0qUj8i8fxnC.G2WfiFNSntYuJ07J
 SOawX
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sun, 17 Nov 2019 17:31:06 +0000
Received: by smtp402.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID c6798c62e8c1ead5e69d3febad10556a; 
 Sun, 17 Nov 2019 17:31:02 +0000 (UTC)
Date: Mon, 18 Nov 2019 01:30:55 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: Support for uncompressed sparse files.
Message-ID: <20191117173027.GA21516@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <CAGu0czQOorHC=JxQVpWDB2KD0NOzh13OuHj3r_4_U5hCWkkNwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGu0czQOorHC=JxQVpWDB2KD0NOzh13OuHj3r_4_U5hCWkkNwQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_181)
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

On Sun, Nov 17, 2019 at 03:40:43PM +0530, Pratik Shinde wrote:
> Hello Gao,
> 
> I have started working on above functionality for erofs.
> First thing we need to do is detect sparse files & determine location of
> holes in it.
> 
> I was thinking of using lseek() with SEEK_HOLE & SEEK_DATA for detecting
> holes.
> Let me know what you think about the approach OR any other better approach
> in your mind.
> 
> PS : support for SEEK_HOLE & SEEK_DATA came in 3.4 kernel.

That is a good start to detect sparse files by SEEK_HOLE & SEEK_DATA.

And as the first step, we need to design the on-disk extent format
for uncompressed sparse files. Is there some preliminary proposed
ideas for this as well? :-) (I'm not sure whether Chao is busy in
other stuffs now, we'd get in line with sparse on-disk format.)

Thanks,
Gao Xiang

