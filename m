Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 73156283296
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Oct 2020 10:53:19 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C4ZBN72QBzDqDm
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Oct 2020 19:53:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1601887997;
	bh=YihIIQ901qRNmvQpKZFksI7mfFTei16yXVIkYkkjKjU=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=QPmrZuS8Lpofs1LzENc6XLrh6ALnThSfTmg/FL39ou4CZzySVEqVPUXZY0jaTRNGV
	 O+D8JwgCBd9MIMZ5je/uT3228P/23sy2lgUCrhBRZ4c0tNGF35Ekc2oPLPCItA6LQC
	 /TlbsWAg36aC64JiiW63AK7deIfmkOCAzg3/3JKXpCnxUjOhCYBt1kwHHEZlVMmJKH
	 Y7kTvtFJVcSJ9wflrrOLVTQVia5hozo8o+anWCPyONYveucKvlUfGoh5ME1CcHbPTK
	 PG6rIfuhfsVzXA65Pm4H5KMCqrtVRJnN6i3v9/Z46JbM10Pu+kpfPJ0Ef5KAakJWda
	 t8VBi8jaq3G4w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.66.148; helo=sonic317-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=pu1+d6vb; dkim-atps=neutral
Received: from sonic317-22.consmr.mail.gq1.yahoo.com
 (sonic317-22.consmr.mail.gq1.yahoo.com [98.137.66.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C4ZB13F4fzDqCg
 for <linux-erofs@lists.ozlabs.org>; Mon,  5 Oct 2020 19:52:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1601887968; bh=qllqhq2qFQ0qUfvltfxIVnThB1kZtoutyYjeo3HG3g4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=pu1+d6vblsW31HgyqdbombqviG+86I/7hjRbf/8ueZArHYRh6REQXfmoOmdDkZ1fgc113lfzOSKAxI49otIvO3Towj4gSPYt2kfQ+XKTev07bnSG8mQqpotosk4H/VPx/WSaPi1RRqiDNOtnccdyHqlp61DCiqUVz/3Xvg/vWN+R0TWLctPOTDuqx0xP4g2vfdQkEzH/1CNMZWSBjVgoGINKVT3g3OOmVMHFgOCN+Dy8WM5gB6aeVN9R3OiQSRSIpUj4/oypPG7gkUhBdZkm+RptGeiV2pwvLcGMhS8PNrYGgKe0II8odrnfQUkkHeOqGgo1wOC2xuBI0m2NcW6BAg==
X-YMail-OSG: GnF556gVM1kjIkNjUkekN_MCBO3T0p9DI7wkrbCUZdKruMk4z6vEkQ1fK1MorqV
 _04Tcw2WpfeYx8e85HKsci.HqteoefjrYoOSTNfoHoCMOrnslpy4kP5WckAQ1moMqA2tjfIpPpI6
 m9jWHb63sf6Rgb2oyQtLU_LTRTVk2jXSQg41uRAFnCfSK9k0nVCEhaW2L5Jzz9ByaR5qhr_4oD.e
 lNH1ATjThTNIlaeWcIydGws7k5RMWyQACFDgpROOTcxp1lfFmOLXs.dY88ZPms4BWMvT4Ithjkjp
 UbukM8mNcr6s1FkmV7LzvYlcMYPiPVdunvwblptKxQlTnY9aKAV9l.fD9ly9TG7Hvlnp.zaP5YBE
 bjBD1vygp7WsaGslEmYexrJI65QI7vpPlX_S1OWsfBb6XAbwwcSvJXlNc32vciuvU5obUfPLyOzb
 Q2pICiaV6RWrJE9tUKXrJDiTX9uElcuvzggU5u_jqIs.y6odgnZXlw4f3_odVsAa5liioq.HamJz
 dXIxrQj_N1AnoS7qYNXFplobwgciTg9nGxeOnerWmKVpuYPl_DzU5XXtA19ssAtDI3Zdmrbprsdh
 LxNIWPACCawBdcmtxMHX8CTOkx0yydI.KeiJx3an_281P4wyvTfKcDE3NQxmAYnNRkZadxtlufG1
 B4tiGhI7js4s6bH7xJK5pamSlZMXBjpUCDkOiO9ZprTcGvcZbKAF8OTbVrsJzn0fMHdy2Npd2n4K
 cy1pLK8pqerZYbTGsjHaeEWR.td7bjqbw9c7HSs9qZD4qfGljhn_iUfO8t5vSc1V0b37lhT83ePg
 VoMSIeRiJHNGJrlkZm2tTLDxox0G7NlbVnQqfKsnLoMapiCOXgKaLsTVDhfMOeHvZEuJ9yp1jbSG
 y63eJ7ZSQwlDQ6zLIHVwDplNqp_MOz_bWjJuDMZGYx1gR8k_Yj.6sc.EmJJHthNraNqKWCj0PbVS
 hT3r7nHSy8tacA6TcFew5YsMYIbgN1VhGFulo8Th2vQ_fGVfoYUldP13S.1uaB0CU9FqsrekbnXj
 Pfq5jEeWQDoCkvPMqYiyMMHgn2IZS3JwNnbv4Hy4AZh0C_8ngwO6rFk.NnUvZELbaypk_BTg83nb
 gt0gzYAwXA9YACMckO5qZCrTdR.J3hQarZvUWW.Q73rLKj2rDjfYqJVdy6IY16fLritSvIrl.ah0
 _3vVD1_yOI49dKbNsOe7Bwj24wcY.FlpMlmIEm01h5dySMj6kRrPsLgYvegphy8BBgCpJERQy6J4
 a3dKR.i1k2JoIOTxxx9p7kCK030vcDyBie2NpSWM7v4tddQyUm2JjJvrPizfq1aWfwtE3twcmdBS
 bIIcvTMf3NVUvebXMZywCuzXYQ5Fxxy9s00bGwsmhS_tKRcI.GEHYncFQkur.XejiUPy69OGwZS.
 Wp7WhnV9KBRRRIZcC3wMiMiYxifMFjkNuxeScZU23vaxJ.YDPZVlnESo2FkXzqeePWb2sb0r_VhL
 q3dlIV9nvgXy_lbfCIamD.R7.Zr5Rx40ggusR_tWpsNaW1Q--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Mon, 5 Oct 2020 08:52:48 +0000
Received: by smtp420.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 279a67c40d1be20734964bc23925dc2c; 
 Mon, 05 Oct 2020 08:52:42 +0000 (UTC)
Date: Mon, 5 Oct 2020 16:52:32 +0800
To: Chengguang Xu <cgxu519@mykernel.net>
Subject: Re: [PATCH] erofs: remove unnecessary enum entries
Message-ID: <20201005085230.GA14487@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20201005071550.66193-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005071550.66193-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16718
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Oct 05, 2020 at 03:15:50PM +0800, Chengguang Xu wrote:
> Opt_nouser_xattr and Opt_noacl are useless, so just remove them.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Thanks,
Gao Xiang

