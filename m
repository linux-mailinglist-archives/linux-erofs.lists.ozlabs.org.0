Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6455CCEA9
	for <lists+linux-erofs@lfdr.de>; Sun,  6 Oct 2019 07:01:43 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46mBKX6mTmzDqSc
	for <lists+linux-erofs@lfdr.de>; Sun,  6 Oct 2019 16:01:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1570338096;
	bh=qgu7QeAggvZVVomY9bMKDz13kBQAMFfY7sFMxl7rHFI=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=lk6EEJKg3JRItQovqaGUnMycvS3lehD8FELwdQ1sx5MMW+z4noYGl/f3vmpcgkJ57
	 pucW/pOWNWEnAoYFs+pZdRYsuapW+r6VPafLJMvJ+JYOhCXmHngfGulQGTpsut97We
	 /0j8DblG/hiYOAmBGpU4c5VjcBydCLp5UVJZa/fd37rXIKbyUq8fy1h4rl67oWDsHT
	 IzLglekG3zi2eucYkqg3f1I39Sz+qV2IxYVBnn61VgiVDKOu1jwlE6O7f4tExVstS9
	 vJi2N5111mx/wZD2AxvxRhyUbcdVKRC10E/Sdg731rjlDaSIux45hUcnfhPzn0vI/1
	 5rWEDa+kUSsaA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.69.32; helo=sonic316-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="VauO4gw5"; 
 dkim-atps=neutral
Received: from sonic316-8.consmr.mail.gq1.yahoo.com
 (sonic316-8.consmr.mail.gq1.yahoo.com [98.137.69.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46mBKJ13LWzDqRv
 for <linux-erofs@lists.ozlabs.org>; Sun,  6 Oct 2019 16:01:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1570338075; bh=/BbU1qIltSk9z9tXe7mqk6OO1ZBXN/o/yZP2i6zuWuk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=VauO4gw544DFj5mOOOc6VtsEYyMlyHgLytMR48gHUlBZtR0NiFXbt4mJAxsAft1AmSK8OY2B2BhFWLDwYmQA7njfFQQQuYD/QsZ1GzfBNKrbLLb7/WskRGNGEoo2HmrYVn/9WwizmOBNNyPwRjZ9F4mNivDyPhab+VooVKyG4IUpFdgfE22zF5Ki3dm1drI7tkHc0e7SuQXJX/F1nT+Fz5n6+dfOaW4VFqRwLKjb0GJ2/6UcpNdDdtA1HKorrYtGuYI9Jm6WiMBszxSROmVU6vCW0bOGEVVIqp8sqMMCGjL4K42PkvSFYBkj9l2B9tgERbofnqNMU+56vVrBJZOqGA==
X-YMail-OSG: y0AUBL8VM1mwvigPThIvZbw81ysKPfnEkH8kVO9HsatnRZ7gRSvwNx3eOzme2yl
 B9UJTohUd5RjenW1rRa427exKw6hp1pR83FBL2NrNkOUhJCPWKbGhzcJ49nDP4R1iHQGdx54ODVl
 aDoggjyhcRri0igL9DmzBp_JpeHO3vItzZwjIbpqe2pcSiLBvx5wvg2zobycIkjMUSDtJRzjj_fB
 D9ADcdNBeO0fidWLGkC9UMswTnG6MK1bkJ5g0J32lsEe5BvoezmxdC4PSBMwf0t8nLj7ce4_Jws1
 9kQw4S9MkHvS_DGA.msS8iLkN5rAd8DVMFhCt0cR.CUiN_5BMkm9sCUyMfqvZ54IXSMUnbgjsDJn
 U2oCbdsOGGPtTjnBd0NSaHNaRIY4juVhhgPHtgW8Fxr60mhm264oJZZYZBmHjGIxjyyzDac9LQP9
 SNUtxKVp7Be6dHAsz6fKBMGXvhHoyiJ_0lVG9GMc2rusdEn09QIW4G.GcwcaOHrgAIwiuhXqWRn8
 VSNy6w9538Gj6jxNusOGEqiMCRw36T1Ua_thtWKkcXF_.VHPBGCcVMS6mEy7vX7QzB3SE.WkYbRk
 jNnls9NSaCek4hcSp_KMRwBJceZBo3epM6Oj_JFo.M_WkZ9Vsj8czkjlw4sL0UNkDUsL1azUV1D1
 8VclCp0nyd8ya3qyvtehE4s9f.LqInHdpxz6QPx2g9zwv6oYCr.D5AOtbC9zkpQ1k..asMXSWuZy
 dfQbCmmWems3N7SPy3snviUnb9McYRYPHK8A6cEWk7LOIBBBEc0PIl_OjcIb9hwnfY.NbGgCwGCZ
 qsJusidbH0rFXh3.hKCakj3M69Oyjb4L8RjHlPDJLfLIDU703g2StIY39zFwgtVjZEXyyZQMk2pU
 81tU9.J1_xPUZW4bd6EYK9m6fhjVu7AggfA_x68MmkkO_zrEIIBjQ6vJnml1tgsVPT7IPATaeemp
 EfttsWcsddsCL8L2ARqvCeKIJaIb7x7YEeX2AV9Y3Vj7UobCvPk3Qtqcj2JqwmSkj45ZRcF2WtXx
 g1l92l9utU6Wyl0MYTIY57MDCsPaSWjgRa9xXHzhedE4MjybPAaVZqfnHEXi.ohuloufU1byQYit
 1nCAETS5zLZmpdgz_le5p4aLQo38JG0f79S5HhbaBe1J3guI1CG5TtlrcKCHjrAV_mwfmjPkwKxv
 7XvRNvDrwxU.K3CSL.672to9PtsgKoiUwuBy0x0yj97hB.INJWHtX7vWf_4Ehyv4BGYCrdhU78I1
 p6tek_.7ZOzSXWs46uJ5n1t5zcoJ9zdsiCs35QAWZ2tB16OApCfxkRcr0fKlge2EKaRWJVZvHXkR
 YOXFHY5I-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic316.consmr.mail.gq1.yahoo.com with HTTP; Sun, 6 Oct 2019 05:01:15 +0000
Received: by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 150795a97862fa0d32a09a497420f8c6; 
 Sun, 06 Oct 2019 05:01:12 +0000 (UTC)
Date: Sun, 6 Oct 2019 13:01:08 +0800
To: Li Guifu <blucerlee@gmail.com>
Subject: Re: [PATCH 2/2] erofs-utils: introduce shared xattr support
Message-ID: <20191006050104.GA24328@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190811171049.26111-1-hsiangkao@aol.com>
 <20191005142050.8827-1-hsiangkao@aol.com>
 <20191005142050.8827-2-hsiangkao@aol.com>
 <ace894c2-f2f6-9c1a-80d3-045bdc9ee0eb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ace894c2-f2f6-9c1a-80d3-045bdc9ee0eb@gmail.com>
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

Hi Guifu,

On Sun, Oct 06, 2019 at 12:43:21AM +0800, Li Guifu wrote:
> > From: Li Guifu <blucerlee@gmail.com>
> > 
> > Large xattrs or xattrs shared by a lot of files
> > can be stored in shared xattrs rather than
> > inlined right after inode.
> > 
> > Signed-off-by: Li Guifu <blucerlee@gmail.com>
> > Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> 
> Dear Gao Xiang,
>   Should It need to add a configure parameter to
> cfg.c_inline_xattr_tolerance which is a custome threshold
> of shared xattr ?

Make sense. I planned to add a brand new command argument but
I need to refer other mkfs first and see if some common name for
this. (If you have time, please help find as well...)

Thanks,
Gao Xiang

