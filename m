Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07674309B47
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Jan 2021 11:09:53 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DT6JF5l1pzDrQs
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Jan 2021 21:09:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1612087789;
	bh=8sIswEO0im/tkCPuhY73E2Wpbg0U0W3V0f19twBjkt8=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=O7YfroJ9UyQYjWe1gd/AMSDZZPF8UstlFgtJR6bT/HlEoqz6fZaRflvPpCJ0Lg+hY
	 3W1Nf1S9M8NwM+15XlMnq0T9varjE9LcUyn7ObAb6pXW7BShEmCsinzc7Whh7gazjB
	 JjRjljrWRYz0d5PJ1tH9LVta2kPil54KHbLsr+4M8ROZGGJg/4qRK4AmDxg1dg5WGU
	 PvWOGXZ1eLpLlk2gehwFkU8dwldE9pKcgPwBxj2Wmhk7RYzxw5lFTODu3hs57bOlgR
	 iE8uOLM14i+IGkrKCYwtEehe1IYwr/PCmTGMOEmC6mfCmY3ZexfAHgiaRWTGagrVtH
	 kN9/LYcgrLEZA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.32; helo=sonic315-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=IUHvbrpb; dkim-atps=neutral
Received: from sonic315-8.consmr.mail.gq1.yahoo.com
 (sonic315-8.consmr.mail.gq1.yahoo.com [98.137.65.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DT6J26B2YzDr2d
 for <linux-erofs@lists.ozlabs.org>; Sun, 31 Jan 2021 21:09:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1612087767; bh=EAtuJhHutBDjQofr7mG7owbX8b0OAF13q05+uUO0lfY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To;
 b=IUHvbrpbTqpJX7JwQSo2G+eDuvKglkZNQU8NOLrNTvdiOsAiTlnIbJX0BOq/5NwCkUCyTvfJGZgUfSm8RMmbppd7riEGpn7LJpeY8qnn7vlDetsHJD5aruTsXD9dNkFODtwfcRetxiGOjAuT1xdiBsqo8W3YReCOBAdmoUHCFeQNnq+NcBvhqcjRk5x3tzFKLrlme3kR6XJsqSpyAvIUmrYm+8uIVdbLBiQnYJcEFx/ycd9+hutNRgIlGg1cO2vaQnlcet6rUQW/JHuipQ2dLbYlFcNa3mmxcbAofyYrCLkn1FRxOBjN1bL+nY/0tMxCcu8oPbp6iv1xMaiDBpvMSg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1612087767; bh=r1nkg1yJSEtezko15IFPGZjfUa933fbbFW2hz5X+io+=;
 h=Date:From:To:Subject:From:Subject:Reply-To;
 b=gtbULXCmQFte4VNaDAequ2RjMJ5DeU4r+eIf7dAgr6u4/cTJfjp0kdMhw76yu9Wd4qznm/XMkBsOazr4e3fv7C1nqIahpeAvFMF9WHdD9x2P1QivbgO+J7y1iYgMZTY6cYjPPtfqqGAv0QlLAd8mJybb1AhX2YlOTd9ouwBSjx6ujpnhb6bjcFLedF5vMqvO833CIxizlcxekbC5/47uZAR4Xj+ly/tFuCWhD10YDEuPMvl00G+5g66llQ+G7QC5E0GN7LlEaOlFlajAQ0/2I9/tpxn2mfnHnI3BkHGJPfU1M/vWX8K/fjtNwvJL9uvoXpyleZiHG7e+zfvxtNgg/A==
X-YMail-OSG: RX5eV6oVM1nBL6lqkMyyCAcspEo7AeWKb96utGTqLZiYy0x0QE0g7gzxTiPurZR
 QXRtSECmJ6ehL5YtmWpYKGfMrM4RqwlROQc9VV1tWBtHIhMJKjpDgh0faEJHJOH.IsmQnrEa14KM
 nYZkseE.ZxR3OY36IEW28rGz7gaNcI0bGwAV0Fcf8iZyHpP56h.ACjXIbdIEIJ_rLmy1x1qT033s
 wWMt1q6Wto3XKjguqqJw3xn22KJzJLMiIALRhrAgYJQaHfUTGQtA1_zOynw0uwvIasFZ3fkPhuvH
 6uDHvuRasGuS7R3aP4zjw.vBMzkvkrUJjlr_ajxI7dhpdiA5Qzv1LaINW_j1txKCjopvUjPPUic5
 5FSSZDFCk8FCe0xiEBmxGhZ1qL4xjHHMOBfWw9XRlLaabF6K6gUOMfBcABujbQAKCmK.Q24U2.op
 0qOpnSSSAgstn4hpPgewRiMWciwjJI9X5HUwQyI6axoXqCoz2MvL6kunbfByA6vK0ktoYh7KM5uH
 C6LiIr_g4MBRDErmvZjlt1n_zVLS7HSM5OrCU6l_.hFXURsQwUOHrQVMsspz.ElxYjGEb4Gwimcd
 I3GX344EWrbN5.f96Cm_xlAso0cM0pjW4EpuYQdNVd2hPb__O.8dgrR2k_cGfC93PxnBc6SzSa25
 l4LlRetgiP0nUMWK5t6or2md.Tbwu9Gwvcju5HCbLv9oJnWXbFkpMTQmm1Uglu41pVllY_yZ1nf_
 jAo4.nJkvEdrL74NqYegQtAVce6u3uNsK1Gq4J.CE6FjbS.YWPtx8HSpTwFGpm_8NicO98zqI7MR
 N5Virh0P1FUHn3fxRehOhx4RQb4DxR1nclNKqzzZFfWmpCZaK3pFpN7Gw4QaVtv1llutmqNpUuq0
 MuuBh_XkpOqkiUH2WnEI1u.s6uUnSV0OlcmYcPesZPULgRL5l8KudIvrpNa06Ynh3_4VhMG2QhPs
 xAHJNLhyVvbGuRXFafLyi.k0pXGfv2APui3Nfqahzo8nCW2EltJ2s.Xj6MN0rJb6JdFTT6fOSQc3
 vrHi7N15UYJzxbTqj_Qso4s75dgQMGeHUnsmjfFhQ_q9kdo39JguNRWOdLVpjdSxPQ33Bn1ZhdLi
 7m9I13EGAhD88zL0DYG1W3zZTSfI_UpzTYoSs32eBMwFHEirRRT7khwHoFdDzvdXBLI0F5Cv7voz
 cy3XpFLJcE.SO0qItPRHyUqAfaj8OL7KAERGw6cscRUKLz7wBSqkPS_EgHRmjE_iPqM84NP58jNF
 qtHRat0_gzyGLXpMnCCuhBU_Uz_xpmykKuE0WrHZcktB1Kn5daFNCj3HBgaIc0AZ2TiKiKI2NYGm
 19Je98LVArNpXiMfSRnqWax6ZVH2VpXP1yBSUxfjbevlnf26VDe6GH5jUDpNaPj6HvBmn651ohxR
 kAOw0VYy.nRT_5LAkkzSy7sRjOCUapSVwEnrfgowit_nnSP0ZvP4CxeTTOS.y1ndAIaXlBzI6CF.
 cKOlMKyCvXd4vaw0agEQgBa.Yw8OLfsVGUKbCfWsCwceFKeTaAsz4TPHqMh9A7gNz6.qAfdGRzKn
 B5YMZsIcIpwrHX24ElH83FOVudFjlAbf29QVJKsYyySTRWLCSQWYGz9TR8dkiWa5.Y94kJFSKCqw
 SICKeMxFN.n9i4MuG.LY6vOmsJOAanCJIJqSXnyyl7Xkv2vRFcDC1XkPobGIHlHAemc1.YRgqLEK
 yEGMPnQNizxEU9N2zfScfcUUxBAmTFrI2_F1nd9KZnY0S2zww9Sk16_g6tg92pMKJDMFmiIt8Mhi
 LB9CUzSc.CmhlZrYU3ER4BHd6YyadrMaBcg6X_XuHD5i6DpumSupkbrfXKcSzNCu0V.gYVsUk2XS
 81AkQFKdf5_wtGWuZKHXL1h9HRXtUuAozJPj5w51mx5wpChBZ.2lU8Qa6UqYAu26PPbeHbQrXMVB
 MwljJtbskUrpvD7apedaQznh3739nzvMCKBLA7AtThHCibKAHDX1tRbkcUi.Lx1ZF4aV8ApIo8SK
 AYqzS7ez2MkDLycVoPyahjfQbr07b3QRg_Jgzk5tddm8vadiCa878bBFA5ou8W.gAbtnX11W0Fz9
 mgPvp9q3mnbxwXvy0h.R.rcVMcW6DQc9vfQjfmeETeusPBVAgHSesGz8aOEK5PGWR6T3YqhZ5PAh
 En2daVkSUepygXS9Zhs.L39WWJSN46YCgkseq_wt2tw1Di4FiJfyVUR0Z9XM.xixhvwVP6p35Giu
 1_QMq95igkmj0votgTR..PlI_DcAGSn2tMfQVN27LIUZEQOLG4qSwDLPLIP6e8IGZvo3ElWSDUHa
 f5FxiCMlbzE1me1b46RpLmq7nXfMmaEajF6beKq7n9BWz1UAd.ElCjGfAdtBicDVsPFz_x3GlvqR
 hpDVC2gu3wWgbJMdaFpMcMiu6ENuK93goIO3cqF03p9dfiTGZnwNZOiPayPAgs2pHdyIuXU2f.EE
 66DuHWjrsEQ4CDlLykjdfZaWfbPclNv3XwmZn.UObszPx3hP7PsR5nM50oU68krzVxFK9AktdUlG
 PGpz1qMo_G9drUmVLfl9fvroD_Q--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Sun, 31 Jan 2021 10:09:27 +0000
Received: by smtp418.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 3dd7e2910dd3e93f9b7efd5c809802ae; 
 Sun, 31 Jan 2021 10:09:22 +0000 (UTC)
Date: Sun, 31 Jan 2021 18:09:15 +0800
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH] erofs-utils: fix BUILD_BUG_ON
Message-ID: <20210131100909.GA21719@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210131094732.168784-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210131094732.168784-1-sehuww@mail.scut.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.17648
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
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

On Sun, Jan 31, 2021 at 05:47:32PM +0800, Hu Weiwen wrote:
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>

Reviewed-by: Gao Xiang <hsiangkao@aol.com>

Thanks,
Gao Xiang

> ---
>  include/erofs/defs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/erofs/defs.h b/include/erofs/defs.h
> index b54cd9d..2e40944 100644
> --- a/include/erofs/defs.h
> +++ b/include/erofs/defs.h
> @@ -87,7 +87,7 @@ typedef int64_t         s64;
>  #ifndef __OPTIMIZE__
>  #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2 * !!(condition)]))
>  #else
> -#define BUILD_BUG_ON(condition) assert(condition)
> +#define BUILD_BUG_ON(condition) assert(!(condition))
>  #endif
>  
>  #define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
> -- 
> 2.25.1
> 
