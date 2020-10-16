Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 186CB2908AE
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Oct 2020 17:42:15 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCVl84VPKzDqgf
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 02:42:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602862932;
	bh=ZZx3zjdJ5ioQ6l7jDZ85ZSa7a4BxKrm6n7Inw0MPZsQ=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jpoa2/G8TtQNFtVbJy6/vmdSQhPsh+z2BEu8NaW8mtuszS6wVjg5OrT1noDXIpSfl
	 f+L5udKG+OxUFev7TCxWb8TjHuTDl5mKsAjgDi+/O35Z82cTLKgMD+6XHNCgJLqb8T
	 U53udTJ3bixj8pe8wjYO2VN2gy6AF8oiIfFkFIQ6Ahnos6yaT6134rBMopqkPiVPC4
	 mXLOWf46o3J29PFzoBRH+0RHsc8z2kt3Iwog61YAEZHkVS6lIREZ0GuZCcCq1kLgGx
	 CWd5IWTl9A7IF9q86bclozmcmDdnTm6p+RAU/Zge0UM/ItpheWrS8Cbh8cQ5kyP8ZD
	 Z6SpBpov9IJHQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.147; helo=sonic301-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Fa2baNbq; dkim-atps=neutral
Received: from sonic301-21.consmr.mail.gq1.yahoo.com
 (sonic301-21.consmr.mail.gq1.yahoo.com [98.137.64.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCVkz42CWzDqfZ
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Oct 2020 02:42:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602862917; bh=Q7peeSQbofPx8J3pKEdRo0Wn8RoedECXYsBTWHgO0DU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=Fa2baNbq7yUa4wUSPZ55OquvdhpmA/Vn8LO9OncdJk25GM/FDz2cQQ/SKG3OoxNNIQdEu5/zl0egvJ55O+WOJ6wL6ndpRQxZzKZB1tN/WcrQMrrO1f5KHm5tylrfU2uGo+Z9Y7rWws8Ba6iqykuhZxwTG9x7ccwXgMKLApdqHZH0e6/4AtHB3sgy2P1ZpRypD/4w+uVeOZr8iBq28CRgAmyOia7Jy+5jrGWyf3uQoepC+h+NWSIMCMdI+Olutyn225dOgYM/I5lRkNNUPx2NNt5rFsJDq/zSN+9C9FHcnGD/l4sH3XGzKlUBbgQlcdhmnAbWUWDS2Ry6aNfFl5PBJg==
X-YMail-OSG: MqiwUmYVM1k8b96C1GSGbm781iKiRA8GcMBwxBwzre2P_MYMa4m93m9BHXxPIEw
 v85Hg0WguUG7w41iARfIxQirb2.hyxJoxeuCXZIRWQHFgIfZRASpDwkTvkQlCwiPGmvodUYOoCZ8
 3kPwixTT3p8zL8xR2JiSmVBFum1dme1JOQGBTFY6.rTOJ7RI4fyWB_gZRcJ79LeHK7vUDLtlcQnc
 sYxemBncU670u6VWbl6zFac5bFpClX6ta5iTnG0xMKFb21SolIT5Cau_tgH8WUl5JnNJKOtCW.WL
 ueFd2jDoEt3crH509JfL_oYIt74ZUdxzJS4roeXNarAvI9LtzeJmOAEMGOKv7Pc9upLAtI8zWwaA
 MT7Mm1.NDmptErYXF6xskERNmOpn68UwpP8l.jOHW1nsFnELTm8Qb4UXuYCAy1Yqzf6jT6XW7oWV
 uIl0UKMd5xChGSH0ER2Eoj1Y9nLSMQNWysxZ3hTm6TzlXkVnW8fqIpJC23fOvmRWpsZh.M5mXv7S
 hFOoEFTeZbCdo3p3qo325fZWynzZjII_2R8BEfLdIIT6vh65x8tH72xMjaM4SI.w.Ez4QP1e8RkC
 RX46FPweKrh.DtqF2wWZ1aphfknKbUAe2NEBLwt9tvtDstlqUsnJK2T_qAx8ioUwV5iCqZDPvKrU
 02ewVMhNyW0TrT17FuVKxFembGaU_Sihj3Q85bhDFMZgItz5UBd7ydIzqXjXpXjSux4OltVVqI7F
 ilKFM29xDWrGtJraaGekEAsxJAIkAlH8mRUEpsvqOeuvH3vI3IAiC1FL5NgnuYb0VefX.rom4pNj
 aw8Ahi7jp0WtWFDBl0sXdeUcngSvJIe0wAP4uMc91LQlHxnAnurCTPBR6gynz39YY0Urx.WRwOmA
 oR52wPh0H7t3aUo_fe5E6ZUfy0ByP3pg0fIO.VbTHoy2Jp9aXZtfNNAZ30p54rl7RXyWNtOgau7R
 .warRWfFhX8IB07O3_0YCkLPAuEaiOVpIQqEjEjvvSuv5mT0WULMumEdv0gsCCDAaA707xcB7p1y
 aBQRUM.jbGwxvj2Z6rkMDAgo_MrBQ5WO_v.ajlkBNiK_syThxm3WSPZdvKdsuULybnXRMue9cD4m
 gzSII70IMvj9fM3ZeOTu4fRlNuLJeWHxU964yM9EVxkJmADAyGSX42rwB9TRtLzjXwWyii5x3ZC0
 27aMDFAHx.P9hcuaFKs69sR4ZKcvRLv8a9gn8douAVhIJkayUluZSeW0lDv8oOkWmHdOkMvYPpaU
 9hQ0.CutoVpySM2fsQ57qzeYoaU8HPXxKaILxPvn0AFgxC.Bd3NdUptHnMnwkI0XnPdL_Vkjfx0m
 VBPTWuIMbi5zGOg9VqLV5.0ryPEiLz02HA7NEkV8Y.KMbWsWPLuqd2BQP1X0ALnznUrhyuDPLWny
 3fHB95fVD8wF7vjoljFmqZ2sSrz0YLDge.zFliOX7aSbBHbL0sFuLvlPBO8eOPW6IHhNxqBGLMpI
 .CVntshuB4sEMaSJB_9j8vwh5RUrM4Uf6lZYKf32btUbRlJPTauL3yolEUvR8xatrRaP9OVcmxnd
 eSVHI8uX3mORGDg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Fri, 16 Oct 2020 15:41:57 +0000
Received: by smtp423.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 193dc77bd2a829fa3202529cf8774e3e; 
 Fri, 16 Oct 2020 15:41:53 +0000 (UTC)
Date: Fri, 16 Oct 2020 23:41:44 +0800
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH 1/5] erofs-utils: fix the conflict with the master branch
Message-ID: <20201016154142.GB32727@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20201015133959.61007-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015133959.61007-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16868
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
Cc: guoweichao@oppo.com, linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Oct 15, 2020 at 09:39:55PM +0800, Huang Jianan wrote:
> The current fuse branch is quite different from the master branch.
> So fix the conflict with the master branch to support the upcoming patch.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>

Looks good (although the original erofsfuse codebase
really needs to be cleaned up),

Reviewed-by: Gao Xiang <hsiangkao@aol.com>

( btw, I'd like to fold this one together with the
  original erofsfuse patch and resend. )

Thanks,
Gao Xiang


