Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 060049D1C6
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Aug 2019 16:37:54 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46HF3L3hPtzDqB0
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Aug 2019 00:37:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566830270;
	bh=44Or2QD3hUGxXicW+r8tJOxpeZmRb2kqGQ588fHhKu8=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ARWPUqmu1e2X+QWjNhPmr5HEVGoB2Ih5H4Pw14pQhvkJ8yQ2PVYh7wfU3+bxtYLRD
	 INTUhH075fWTjrnICCuRehL6V6kYWEoTtMvE+8fjaSBn6mrlyfAFWcUqK4XGqb6Faa
	 N5ZBmWxq77vrlwR6MbcpnLJZKZS98NLc6OVl35ApIuzzvjBqmLQ8adw75tOf2+Rq/C
	 Xpb3Wfo1UzZhCHzLop4c/c8QfEE9eqTSQCwhx105HYFD9WUx3diiVeMkT6uU4E6PYv
	 SkScpdmv1/BpXt6nlHOWKR6Fo6wCiYVyB9wUuT2CjbNC+mzS8lXW+xIxmA2d/S7cxE
	 PVW+BsEWMkUnw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.179.147; helo=sonic304-22.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="bq3eED76"; 
 dkim-atps=neutral
Received: from sonic304-22.consmr.mail.ir2.yahoo.com
 (sonic304-22.consmr.mail.ir2.yahoo.com [77.238.179.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46HDpY18S6zDqFh
 for <linux-erofs@lists.ozlabs.org>; Tue, 27 Aug 2019 00:26:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566829598; bh=CUkBeBfgzLsQe0R+nv4XKH1MrZ/TAXoqFxsCZAILlnI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=bq3eED76epCDJIxamRYyr9sVqUGuOYMvQFQQFGqDNfecn5ql4Xy6BR2HXyEHIcWx4ooDVO4llNLPqn78ocoHN/Knm19DfR8B1r624qSp/8LPCAsYliyPDvL1DdqT6ZlGri4E9y3rhFFqWFaZlHsRsTcgUHwLRgt9Jj9+ImpW9YDTLSDIudai4a/MPpIDJ6+SMo2gHgE3ulEAraZnaN5cAkyfdjeU8zXVCsTb9fobbObE4gfiQ/p5qjMhSzfGTuYE9xSlqoV+iVZnrdjT50PQDUcjz4X7k5qxSNbkCqUCm7tAQAGivO7qNkizRHC2fqJgJpkEQ59wmRAl9bncS3/huw==
X-YMail-OSG: OgJk5BoVM1mL53bHC0NY6P6qwaZ9ctS1dz75ao.5HYcla4P0MsHPxuQL1_Ra54H
 TGKIkokmuTrdH9vc_7nHkGzdPHoeKfQ7yY1dKf00eCqVpKuqpwKoOyfPgFOCDA4Xq5cGTw23hhqB
 kgrTbL9p.oXiOqTPc8Ml1Al4RcTdkBmhmEhEe2eeE6OuKcIBzVh7LGXKQDo_hLJZ47YdpgvBh2He
 r0rBZZooM0wTXDXaaF8MMh1bd.fwoZImN.K8SyJWrG6f6amjl2rdf50_b.jl2Q3xfDR3adxlsaeL
 c5mKZHqtYGu_Sn3jFKBVOupqKjmAjCTJNo8y5oBLt5Qainv49b65GciX5HWXMsGdyP990Ob9bzQG
 W7YLWBaE_nFBzNRCLws49KWHqVxHI5RBDBqPqkHOFVhlYbpaOeNLwrSG2aLg6_cNNLaIq.dEtJpr
 uqNDeC1d1ndMUx8ugKjP0CCSZWQqDCRuCITev386kCzC2u9EwOh9F1GC71SC0Ohd19Yr_cV60zUE
 7LKkLo4CsaLqaBt5YbdiAuSqCUSnEG1EUPdius4JPYHydQcUn7WC0l6DD95D.SNBC9KohMfnGAQa
 FfHxDhV9hrY2nzForWUspe6311PcTJ2NIWcXBKB06fIuq5Lytvk1iB9Y2UuKl2zf.aNVOutZW1mr
 p33SiRmRAcxdzTYeWJ0yDxI_.AfSOhFmLis_20hj37g3wuW4pJrcohDycAJxKzy3C8UggHPVbLIv
 gIC4PoPmPHHgjAt6RRsCeKcqdGRkW2I38zhs.ioGYwuMYU5GUEyEbH2n818kUYvOjLpJ_twTVJnv
 e8.0qPsOoiac6wfgPbjI.1mGvc_ww.DAgIDWaPrcH9bBlIhN8ICQn3S8OuJsW1StWsaCCMj2uZ.E
 qkHkT4kFx3RHoRSPJUziJG.X8lUzAoJp.E.nZ.C33buUdsqHK8XGpJZPYveg4_dARColOQKF9ZCc
 x3di6Y.6S0eUfmew_fX3Nu9f3dokyd2y7cuwq_KAO7sITZnQzYA2FEpjFqr_CCJmWTsR8bOu_q5F
 Uu3V0_4aqjU4YOJe3zGx.I9.sjMImskhGhSfaHtlfRSQlPZy.koikLlUqFUP1e3GCjWoO07iud1e
 DekJJT5XCSu96mLI_N6ZjehRTEJKcsUBQt.L3MuKgFG37fh0KG_9BOoAP5CVpdnfSBWN2MCZOKse
 y.Kro6fIK1UzEbQMJ2REwHTp8hmsRN_TYauG3Yll95d3xhKIuwCVDKCZ1EIlTu4euyV3skioCDB7
 k7q.y.ZwuhZ6097iQU58tZc1Z9SftK39Qek2N0w7eQ4ni2esuqOur
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.ir2.yahoo.com with HTTP; Mon, 26 Aug 2019 14:26:38 +0000
Received: by smtp417.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 1d766d3174bb217f1c7ce281052272e3; 
 Mon, 26 Aug 2019 14:26:36 +0000 (UTC)
Date: Mon, 26 Aug 2019 22:26:26 +0800
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH RESEND] erofs: fix compile warnings when moving out
 include/trace/events/erofs.h
Message-ID: <20190826142624.GA22424@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190826132234.96939-1-gaoxiang25@huawei.com>
 <20190826132653.100731-1-gaoxiang25@huawei.com>
 <50c3453c-a1be-3e79-da21-4d4c84d49fec@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c3453c-a1be-3e79-da21-4d4c84d49fec@kernel.org>
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
Cc: devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Mon, Aug 26, 2019 at 09:51:35PM +0800, Chao Yu wrote:
> On 2019-8-26 21:26, Gao Xiang wrote:

[]

> >  TRACE_EVENT(erofs_lookup,
> >  ^~~~~~~~~~~
> > include/trace/events/erofs.h:28:2: note: in expansion of macro 'TP_PROTO'
> >   TP_PROTO(struct inode *dir, struct dentry *dentry, unsigned int flags),
> >   ^~~~~~~~
> > 
> > That makes me very confused since most original EROFS tracepoint code
> > was taken from f2fs, and finally I found
> > 
> > commit 43c78d88036e ("kbuild: compile-test kernel headers to ensure they are self-contained")
> > 
> > It seems these warnings are generated from KERNEL_HEADER_TEST feature and
> > ext4/f2fs tracepoint files were in blacklist.
> 
> For f2fs.h, it will be only used by f2fs module, I guess it's okay to let it
> stay in blacklist...


Yes, it depends on you f2fs folks selection...
Anyway, this file is a new file, therefore it should be better not to add to
blacklist...


> 
> > 
> > Anyway, let's fix these issues for KERNEL_HEADER_TEST feature instead
> > of adding to blacklist...
> > 
> > [1] https://lore.kernel.org/lkml/20190826162432.11100665@canb.auug.org.au/
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>


Thanks for reviewing :)


Thanks,
Gao Xiang

> 
> Thanks,

