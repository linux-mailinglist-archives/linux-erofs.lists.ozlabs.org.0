Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C73326EAE
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Feb 2021 19:51:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dnwbb0dVCz3cYt
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Feb 2021 05:51:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1614451883;
	bh=mAZ3A0dYL+FCTmO1PIKpVO91LHCKv6e2dWzkcDYWTQ8=;
	h=Date:To:Subject:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=mQiIcTfZ9QJb0dJD86p0+Ehl/Fll8SXwSDlRO8yH/EhRTl+nWnvx+M+2ej9EfcEEG
	 Z81yqoHM7lMfhRVhQmbwmntwplBqdRl3oLkqtc8bTX7UY5qoLmBDV0U3hUVH67V32/
	 CD32X61ZM6Uk5PLkj9JHo+1T7FUwLi8m5KsHq3q9WFflZgsPeP1nNK1vcgn4pjzSC9
	 zt8Wys0uk0Z1Ar9zeAyAX/Ajjzl1CUiCGYxQAtU/32lCzuzDpZwrXjC1NZ0jEhPOoa
	 IENe2d4JqS/9iFVcvubJzBE6rrFCGagNAPWbzjanCr/pFrg+hKr8aArTp5eIcIz72n
	 SBQRmbaGTs8tg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.205; helo=sonic304-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=foNtlNTZ; dkim-atps=neutral
Received: from sonic304-24.consmr.mail.gq1.yahoo.com
 (sonic304-24.consmr.mail.gq1.yahoo.com [98.137.68.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DnwbW47kCz30J8
 for <linux-erofs@lists.ozlabs.org>; Sun, 28 Feb 2021 05:51:16 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1614451869; bh=q5i5ps025/kA9YhGvjB2utL8ejsYKuyNCQ3yqMzFc3I=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=FZ5Eu9n7b2DlwjoD8YOz0l198RVk4M3cdJehhcEVUS/WkEmLmevfhaJT+ZyAHpBREvnkKj+jqvFunvvjR1WpL7Boqw9kWM77AmueNfQy8VlNM/Zl7akcZ+qINdRhljrl53j06KLZOUQgAlelpQjwOHZFsbS3Vsv6EPCLZBX2/r7QBWgLM5irbeJxwgU7oDHjN/+s7SXkC5SDkIxJlc6foqfyJfL/fjLTj0WCueR6wTIK9TYsvKWMg/si64ccjOc81WY/vTQBdu78zBYy283YHXPRfRW6celLxM4RzeQSGmWFa0GYN5kJvRnXgQ/keBhfnqP6gNLH+P2jsizYNut6iQ==
X-YMail-OSG: NBCFwmYVM1mPSG03GarK4J..4Ey4OVJz3Yf.HpV.T4lNk5JNrhttvo5iowz0S15
 VxExEfpyAoOuxBINmRfrvUz5JZAMTkbJVr4P84f8yqAz6XBR7qah4CMzptpIzxUhEA75t8huAVcZ
 zLE4pvZEHOZqDOZUg46ZGiz8XR_TU6YcgcKVd3h.8sQbZfeb63lYQWsfKkqYuTQEtgvyovAKOvjf
 nx8skZmVscL7k6xxQ93uNaTCYiPk9wI8UkFhx0SyH8HZLRJOmSYTIoVGNULCbh2UEqEH1yYnuOvl
 qF_fvSwkkzoGZ2M.h90YIGTW9eHVMvcSBp7eqk5ry_B3flTMmNZlRzgGnkwa2RXnjkE1mRm3OJ7H
 gsyovl20zH3LlhesSSgY5MFLlDkoiXiZd4or7VtiK82rOkrlT_wyl87Ey2pdmRoE1RrZ20yX8sL4
 ZLhOtFJFZH4h0BIFu1HBURL59xufsff3EBgixUmiOhVj2bh0yomV0Zm5TaT9UrLJJMa4LzreZk.1
 jbi31kbMaes1PILawAf68cQqcwu_53AFo_zYGxx_B6JhoTLJHL0E3_mmGExOtkmMZbd4Oj_4OOfp
 FPvog.59HWF.pzCxeq6pxtVh.TBAWpvpFSNoor_KOVsw_3CxFZ6KcLIdaeYcfbzvlHSii9Bwr1vR
 46UOMDDcDZ_5TcdxvQdn_HaYqTvuohetY1y3nYUMMwwy8TzGTS0qul5os78pQzKZwRfacsM.6uS7
 OSFsS49UmZg.Xa3VEATGXBW5S5gFwXHkMkz0Hr_1qgUHYKPVp50FO4SHvFK8c_W2uNuk3aPcqXPM
 CNOP7dojCyyc_ewk7SZZDjvK_9K_CjRS7BllB2GNXTCQgA75Nj31Exhpj9cbyMvYOXrFhCd1PuJu
 8viXLrwbIABBzMoCn9p_UBFGYtyn.DKv0R5PFWwHKxWWqVeHSJaPIEyn9e.7HvECnDX8u5WMI_X8
 akI.tKG3hAciwoUrqqhAI2iZa76r9T7VEhlpJ7kstVkIszmOFRH0zujddjntS8SaBCEseZGS8FtX
 8TaeatHpxTP97B2bmgtTSu1CTi2fLLMzV5hYTFoKz1QTzh71lRk.Hj48psxQ6TTgOebAZeGgYt65
 ql7FHU2JnLRfpcSsjF7gSvQAfDZ08wpVSO3agVskJXT0yPe5YaDwqzH5CfdTktFfWQF3I1Rnqk1q
 i3UJQJ2pnG4PoRj0iU5UUX3pkxQv4vXwAlRI2blg4oLKx2ycStgYePTqD9yNVGRyLP7hPzDicD8C
 NPF2iIyOFBXOHrZZ0Set0XkHzO3MVnMXy5ILYKykuc7CldErGe5L0Q2VSlOGAbNlOBSMlplBjwvR
 miA1.j3wKjes9V0PSUFXOerHwzfMhsb6lC.4iFz4zGkWuzYVFqQQxNM6TQcW.a8dUgAew5muQehq
 TCK6vEhDn5uWldGd4ixktPiFjCXmUEHY8tfWEAzjbucuxnMpN5yGKhsSKCL5KaiOkBr866gw8IAf
 dTlQDsjAA1.tru8HFSGWashmr06s_6IPSZDL1E1W1TdM4BhYOrsc9x8f62HH_FjpZoBQ1xY8VLDU
 X9BDazsvzUfouQN9.CV3v.VpOtrpk0g7FpYKP.3YfJRg0RTNXnyV18w_8OCcUlYnSfcET_WLY5ga
 5tgahQFy_CRaR.KwzfPrY_qM9QnM_VbSpg6Q0ke0ltGVtV_7Z.5tYer87kqipAEsrmL0WRjV8HRV
 o5SDQauGnKXDoKSWKUfEUnA6FLjxPR8IIass8720TvXa0ZrdBwBT6bhqbwvXBtb3jC2lF_WAlcfS
 S.YArQz8xWVuh8mp3Dt6iTzbKxk4VAH7W1r_cjU9sAhhHvcIFQSK2_mGcFPjpUFErur6D_1ciJa1
 Zr6YF3uv8d9G7J.k3vw4dHb5WM5G03qqXg6rEkCXJ2AIjQDwgzxTl53jJHYDWB2Jy77_ZmHv_5Ts
 ol2JwtMpRG88o5NAksQBgQgS.rqDxcgmmLMYQ.WkIrSec48Y8dTdFk03BYVtlY1sjdRtx3G.dbo5
 g4PnCa_MEMrFhlwOug.8sUvdIzZ_72LMXDzR3UJjOOHHhhqqjpYJWLckqKFQ.ivmaGFXeV2v2V2h
 .elDLfRuEEBMPOEPSvKuAK9wNF7OGZ2xKZjcLpBdg3rVOP5Z7Ehs46Rd4hNPBmPBceXjyAAcDacw
 hMzxoraLGS48hOMOqS.0Rw9dvYZV0598.xFVh5JaZx8nEy4sGo3iHGanXZ0xD.UZs6050buHpDyG
 5yuQDxDzR1bUxw75x8k6HDTwVXuseraaknIwG8_IqL_6fb._g8L_oYyQKOBBTI4nd1cUjYwYgcVE
 YiNG5i8Ka5bG5sj5Zszukdqn41Ghe76BJBvjd_RihWXQbsEHNOpRJEuXoTovpO37J33R2quCiKhw
 KFOnUXSDUbRUQu_tgEw3yjRwSNPmrZrMlwBHDS33JAdg330EhXxLZaff_iNibG8byqQGXRofjFlR
 .bus.RfUuUHARIMAQ2P_XFlXpQ.lA5sf.PQWMqOG9I5W5QbGPLF.S0yLvd.IywXsy6w--
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sat, 27 Feb 2021 18:51:09 +0000
Received: by smtp418.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID ca3f02449955539579df1e2383520ab7; 
 Sat, 27 Feb 2021 18:51:04 +0000 (UTC)
Date: Sun, 28 Feb 2021 02:50:48 +0800
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] erofs/erofs-utils: support multiple block compression
Message-ID: <20210227185027.GA13741@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
References: <20210227185027.GA13741.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
X-Mailer: WebService/1.1.17828
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
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
Cc: Lasse Collin <lasse.collin@tukaani.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi all,

For anyone who interests, I've made a preliminary kernel implementation
and it seems to work now. I'm cleaning up these patchset and hopefully
send it out later. The code can be fetched from:

git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b experimental-bigpcluster

and
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git -b erofs/bigpcluster

The benefit has been showed in the previous email, see:
https://lkml.kernel.org/r/20201230101239.GA3282742@xiangao.remote.csb

What I currently saw is that the sequential read can have slightly
benefit compared with EROFS 4k case (mainly due to CR improvement),
correspondingly rand9m has some drop, that is understandable.

The next step would be to enable compact indexes for big pclusters.
That will boost up the read performance even further. Also there are
still some finer optimization for big pclusters as well. I will seek
more extra time on optimizing case-by-case. I hope the big pcluster
on-disk format can be finalized in the next month, and upstream the
first runtime version for the next 5.13 cycle.

Finally, first EROFS LZMA compression implementation will be planned
for the 5.14 cycle if no strange happens. With bigpcluster feature
landed, EROFS LZMA compression can be more powerful then since such
end users care more about CR rather than random performance instead.

Thanks,
Gao Xiang

