Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C4C202B11
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jun 2020 16:38:05 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49qZs65QvBzDqfB
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2020 00:38:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1592750282;
	bh=QeP5axIe8X7jZjuS5RhuyQ0zG96UtpP/dBybbYV5Eok=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=SoAaITSa8As6d0xuWsZALj9J8aOp38JyJJDbXeQVn45XZRokQEk9ZZeNV6wk4HPo0
	 04ITvIGMzhu3Go5RwjC7UE433SDoJk8L5A3dDAQIw/xUKYaokomwQo4b9aqDg2JLeP
	 86zrnp/3MXhz2nb7bfA1SgOOlh6dNlWHOw4Z6kjITPCCbCgzAmENmBZhQ8wPfmDUvM
	 Kejg3UnJdrRA5LkLrwZ0Okis9wF2jizTFhU4bO4fHT8ZMkemlRD/GIvxsFLkIJsDAT
	 mOqJxhaMk5t3t+sEb5D4/f+SzN6VeipLibQiPcd1sx5nNWWV2aGA48NYHqXNxYsIj8
	 LU0sq+Y5MzY1w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.147; helo=sonic301-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Received: from sonic301-21.consmr.mail.gq1.yahoo.com
 (sonic301-21.consmr.mail.gq1.yahoo.com [98.137.64.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49qZrk0zk8zDqdP
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2020 00:37:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1592750249; bh=bInFWLlE9aFbuQKawk2LM+aoERkjD7Fqrf6SX3bTHjc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=ngAUaaGVRxiQ8NSra5wSUWiJ5W1kUt4OvxkIK4HetZNQx6BNqTE2SyPy0OvqTwabPASmhZpNS+lgu8w85u2KVzGzPQucdvsiSwLLiEuwtx+PYlJzN5phXSL7qfu/Ii0khuRVd5WC9hj8IWzcTKtPF1OcE/S33G9sw2TNeTrpDA4rT5rW76Mudw1kTmgY0LbVsPbeYMnUDQObIwu0SoRbrxDe/leJ5NyqvYIvx84O6Tn/NIBNs1xRYIxhV8dDjk+2doCMaAEkBJzlwxBlYazIjwoHnVxJ8XtllRk1904VlsyCCwcBU74Fg5yLGEBpudVtqW9Osz8ia5L1b5W5W2YD/A==
X-YMail-OSG: fo.WfrIVM1kIcwo03KD5e2uW6EkuEL8_saV8R9GwYino0njxb6WUsZvNLDMF1je
 yecfCRHJfHakXgk.v2PzOdLYflIuPDgFYIs7PrSXtkUe4Ha9_RUbiw7v.5k7aHDBTfstLQs27sAb
 rzeziAmq0DoxuGflcvI5DPxEVGSpjpE088YTa0BWjJVLYMPmOXh.VDLvdDBNhL3UAfomwad0jm7z
 ek.3z31SrnROgD07qt3X0J3ajFwc0Usfu52CRayqtdJKt94m1M9NTxOHEXckPa_0u5wzblUdqvyi
 JW4DhYFUBB9eAh1WuSkOabbG6sZqrYAfIGdEwW8613zOrAwsb9NPxYmeB5ZYw3W0564uUtvtC47k
 L1vVYslo_72yVXX6_uiUhSnIxEM11Lp7u0MPRjRJuORgGVkVpQtZBPp5mmFCCXcDbRZRT1f5Pm2R
 0ayaigcYL09XQY5IvT3wfWL.IxQSUCPq9.7FNEcDW2jfU4Cn4r9OX_461vK4iokThIcHi8aXr7hV
 PlkCKD0JZYBSIDOqdG5EkeYhPDZhIoNrqBmqEr5AXDKjpuFBC71p_TRfw_Ca1QhXVdTMv019HpAj
 grpIP2.PYtrGbJ610nknn.O392Uoj6FPGyYWS3RM1ZHPkxhIT8g4DouKB3OBIbd9RJa_J0GCDAKm
 sp0Li2N7MFTZhdefhXiJfmpSKa7nwbXQZOBOsb8idv6gxpFr99qpvtOczUZKSSOiFuKsxy_IO1_5
 BlgaD71NbBi5IDjo4rKV1Sq_9ZQf5OavPQ4YG1SkN0HlHLdcQIdNPeoGU9qWeyrquU3mxrZ6hCL9
 Re3fkHW.upAXf.8p_GqRyG6p.W_873FbPp.VfaPsbpR8RBCtGcBs6.zHBjWlUL_S_roPIxq9cYNK
 aWhY2_mZD290nzMXtvx8UP0TuhuMA8ziae22VmyIpwZKUL7cveytGAMnZZnPCSlvUeLgcFhQsW8b
 XevvJk9mq1hGNLB7Umoeks4OHH7vJSbZIVeKaC9pHr5Sz9msWiURhyrfw1LAU6hog8LobSwhwZEh
 cx5uLHNJ_uIZJ8HF1vxmwWlccisPqhU0m9jRkqKBNmB3Ke7YLVwDc04aWC1DLm5MC3vE8EKkuHiy
 34M5t6Hy3O0jccS.M9GDA33Jx2jkatJVJkRBpXw.cbY87Ey_vOypwmgzOK0dRssruvlQ0LRLBMMX
 TBiwFwr6a0A9xRTeWDvx4tzCGF2YodXdExT6t9egvqCxW3oB1zYx5dzdCb7sDyjqjwjFaQt4Oajq
 aY5mHrCFWXDZ8xcfVtyyiwgcUn1doPo85EQElYutoykPS15PoSF_gAeZRKeQGpGXiRgqgFp8T93v
 QYvLoOSkVzwSVyW9qQJXJcD4a2yg.BQ3sFvdR4zdiCnwfxmEUoaU_JbSEl8mZxHmBp84beYQ-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sun, 21 Jun 2020 14:37:29 +0000
Received: by smtp417.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 077ca12bd18d13c6026e017839a722fe; 
 Sun, 21 Jun 2020 14:37:26 +0000 (UTC)
Date: Sun, 21 Jun 2020 22:37:13 +0800
To: Li Guifu <bluce.lee@aliyun.com>
Subject: Re: [PATCH v8] erofs-utils: introduce segment compression
Message-ID: <20200621143711.GA27245@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200621105147.21422-1-bluce.lee@aliyun.com>
 <20200621122745.26996-1-bluce.lee@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621122745.26996-1-bluce.lee@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16138 hermes_aol Apache-HttpAsyncClient/4.1.4
 (Java/11.0.7)
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

On Sun, Jun 21, 2020 at 08:27:45PM +0800, Li Guifu via Linux-erofs wrote:

...

>  nocompression:
> -			ret = write_uncompressed_block(ctx, &len, dst);
> +			/* reset clusterofs to 0 if permitted */
> +			if (!erofs_sb_has_lz4_0padding() &&
> +			    ctx->head >= ctx->clusterofs) {
> +				ctx->head -= ctx->clusterofs;
> +				len += ctx->clusterofs;
> +				limit += ctx->clusterofs;
> +				ctx->clusterofs = 0;

TL;DR: it seems still buggy here.
Pls rethink carefully and send a usable patch then...

Thanks,
Gao Xiang

