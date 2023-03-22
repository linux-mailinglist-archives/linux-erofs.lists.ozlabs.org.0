Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BA96C5A70
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Mar 2023 00:33:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PhlCH04Fbz3chb
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Mar 2023 10:33:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1679527995;
	bh=VQ1XXSzY+fOhPv56s8511q0JAMBkDM5R/GQsHQA1ypo=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=C6QfT+WouaoX7J4tGGI+uv01+n/12K9FcInwvGHDKIXcDp6PdPZjfCqwkrzJAyB6n
	 W7hVofKMmElIah5pNtxP2rjEINKtQU2Vf5/CjT+toVFOVIedBOyDr8wTMiixWzQ1iy
	 UBzoy0FQtIOxFaGrrievU2WPmKiBhNXktfV8q1qjDUC2JPWy5jkb7oUBgNqgjF1i0R
	 qYAqfqan1cwlagDojo9hSEuza2sVx8z60neOeITZqD1CjFReMnGJs3gt5cF0pEELcL
	 aTeB/fXz88OJHft5+E6eSb/wjBYvOxqJuanAobxNhVIdsgU7q4BDd+1LkaDuzdCCsl
	 fuzv1WCweoAjA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=opensource.wdc.com (client-ip=216.71.153.141; helo=esa3.hgst.iphmx.com; envelope-from=prvs=438b69c7b=damien.lemoal@opensource.wdc.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=ZJLJk1SI;
	dkim=pass (2048-bit key; unprotected) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.a=rsa-sha256 header.s=dkim header.b=Ntpd+c2Y;
	dkim-atps=neutral
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PhlCB1219z3cF7
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Mar 2023 10:33:09 +1100 (AEDT)
X-IronPort-AV: E=Sophos;i="5.98,282,1673884800"; 
   d="scan'208";a="231247919"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 07:33:08 +0800
IronPort-SDR: TdAIQK7n2vjIlhmhjav7yOUEX/nh0bGnfaet/7+cJBkuQhNq4hKipTAflBgNyuK5GsB6gv6vIU
 qX+FFerWevMGD0clVWkPbeoQFQYcxd+zuEH2C/pe6Dr8Ld2KFGUTNKDLNdVe6JvDcSWlNOd7WW
 b6E8rNojLeJZkLkcALgVqsPMhaGhBjYCQ4f0pS5DvkiKRsM11U4vpC5tI6Rq4LNfLclHccroiH
 uKkOOcEBgj2nbNAZ6Kr/2q3h9mNpGz0Wjf22EGCZAwQHpbdmwzWKcjnVRtOa+LTREBwIe6CJaT
 a3Y=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:43:44 -0700
IronPort-SDR: pxRuVxX3Jq+BvysMSfrN7urUkZeQ56CTxpccJhQVybQHvEOv163G9Jc60WGiLXi7oSwhgcvPZO
 e7WhmS47v9BpJi4g73/K7swTL6hOT/nue55lSm+GfaVlG4xy+xHyO1gHqcRXnhzyPLu+xCp7mt
 H75w+Doo+c/IW+gOAA9VlTRp6qLSLLUVZwqQvTUta2CiG7wdY6vkEf8/jFAq7D+OeccrLORBwW
 x8G76wziHWJjHWb8sKltqZuj64Eijr3nSD9aOHoKM8pZrC1pZczHGNTSdV84sfikDLL2ZyqkWC
 GW8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 16:33:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhlC76MJSz1RtVw
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 Mar 2023 16:33:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KahwTq1SmvGh for <linux-erofs@lists.ozlabs.org>;
	Wed, 22 Mar 2023 16:33:07 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhlC60QH4z1RtVm;
	Wed, 22 Mar 2023 16:33:05 -0700 (PDT)
Message-ID: <435fb998-daad-3c09-ad15-f31713b0c3b9@opensource.wdc.com>
Date: Thu, 23 Mar 2023 08:33:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 03/10] erofs: convert to kobject_del_and_put()
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20230322165905.55389-1-frank.li@vivo.com>
 <20230322165905.55389-2-frank.li@vivo.com>
Organization: Western Digital Research
In-Reply-To: <20230322165905.55389-2-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
From: Damien Le Moal via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 3/23/23 01:58, Yangtao Li wrote:
> Use kobject_del_and_put() to simplify code.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


-- 
Damien Le Moal
Western Digital Research

